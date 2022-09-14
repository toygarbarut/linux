Linux Shell Scripting

Bu yazıda script yazarken kullanacağımız değişken tanımlama, kullanıcıdan girdi alma, diziler, aritmetik işlemler, koşul yapıları ve döngü yapılarını inceleyeceğiz. Biraz uzun olacak sabrınız için şimdiden teşekkürler.

Nedir bu shell script ne amaçla kullanılır önce büyük resmi görmek amacıyla bunu açıklamaya çalışalım. Biz komutları shell’e iletebilmek için BASH, Zshell, C shell gibi komut yorumlayıcısı terminaller kullanıyoruz. Buradan girdiğimiz komutlarla dosya işlemleri, ağ işlemleri, vb tüm işlemleri yapabiliyoruz. Bazen uzun, arka arkaya kodlar yazmamız gerekebiliyor ve içeride döngü kurmamız icap edebiliyor. Bu durumda biz kodları tek tek değil de bir dosyaya hepsini yazıyoruz .sh formatında kaydediyoruz işte bu script dosyası olmuş oluyor. Bu şekilde çalıştığımızda kodumuz da daha anlaşılır olmuş olur. Terminal olarak bir çok çeşit mevcut olmakla birlikte bir çok distro ile default gelen BASH üzerinden devam edeceğiz.

Ayrıca komut girdiğimiz bu ara yüzü programlama dili olarak da kullanabiliriz. İnterpretted bir dil diyebiliriz. Girilen kodu satır satır okur. Diğer dillerde olduğu gibi yazdığınız kodlarla kernel’a talimat vermiş olursunuz. Yazılan kodun bütününe script denir ve bu kaydettiğiniz dosyayı chmod komutu ile execute yetkisi vermeniz yani çalıştırılabilir yapmanız gerekmektedir.

chmod +x dosya_adı.sh >> execute yetkisi verdik

./dosya_adi.sh >> yazdığımız scripti çalıştırdık.

Hangi komut yorumlayıcısını kullandığınızı öğrenmek için echo $SHELL komutunu kullanabilirsiniz veya bilgisayarınızda yüklü tüm shelleri görmek için cat /etc/shells komutunu kullanabilirsiniz.

Genellikle yazılan scriptler >> #!/bin/bash il başlar. "#!"(shebang) ifadesinden sonra kullanılan komut yorumlayıcısının yolu yazılır. Farklı yorumlayıcılar için örnekler : #!/bin/sh — #!/bin/php

#! /bin/bash >> bunu al bash tipi olan terminalde çalıştır demek istiyoruz.

Komut dosyasında yorum satırları için “#” işareti kullanılır.

#!/bin/bash
# Burası yorum alanı
Değişkenler
Verileri geçici olarak tutmak için değişkenler kullanılır. Değişken tanımlarken büyük/küçük harf rakam ve “_” kullanılabilir ayrıca sayı ile başlayamaz. Değişkenin değerleri için tek tırnak veya çift tırnak kullanılabilir. Değişkeni çağırırken başında “$” işareti ile çağırırız. değişkeni silmek için unset komutu kullanılır. Atama işlemi “=” karakteri ile olur sağında ve solunda boşluk kullanılmaz.

#!/bin/bash
MESLEK="devops engineer"
echo $MESLEK
unset MESLEK
Değişikenleri readonly tanımlayabiliriz. bazen değişkenlerin değerini değiştirmek istemezseniz yanlışlıkla veya başkası tarafından değiştirilebilme durumu varsa bu yöntemi kullanabilirisiniz.


Değişken kullanmayı öğrendik şimdi kullanıcıdan değer alalım. Bunun için read komutu kullanıyoruz.

#!/bin/bash
read name
echo Hello $name

read komutunu -p parametresi ile kullanarak tek satırda hem adını sorup hem de girdi alabiliriz. Ayrıca -s parametresi ile şifre gibi özel girdilerin gözükmesini engelleyebilirisiniz. Dikkat -s parametresi -p parametresinden önce gelmeli. -s -p veya -sp şeklinde kullanılabilir.

#!/bin/bash
read -s -p "lütfen şifre giriniz:" sifre
echo $sifre

Çıktı da gözüktü tabi göstermemiz lazım 😂 ama giriş esnasında yani yazarken görülemiyor.

Ayrıca bir komutun çıktısını da değişkene atayabiliriz. Bunun iki yöntemi var.

Birincisi: degisken=$(pwd) >> parantez ile

İkincisi : degisken=`pwd` >> ters tick ile. Bu işaret ile scriptin içerisinde komutların değerlerini görebiliriz.


`` Bu işaret ile scriptin içerisinde komutların değerlerini görebiliriz.

#!/bin/bash
echo "çalıştığın dizin: `pwd`"

Scriptin içerisindeki değişkenlere değerleri scripti çalıştırırken parametre olarak verebiliriz. Nasıl yani derseniz şu şekilde örnek vereyim. İlk parametre dosya adıdır.

Önce Scriptin içini hazırlayalım.

#!/bin/bash
echo "DOSYA_ADI:  $0"
echo "ADI: $1"
echo "YAŞI: $2"
echo "Tüm parametreler: $@"
echo "Toplam parametre sayısı : $#"

Değişken 0 dan başlayarak numaralandırılır. @ karakteri tüm değişkenleri yazdırır. # karakteri değişken sayısını yazdırır.

Diziler
İki türlü dizi oluşturabiliriz.

Birincisi: Köşeli parantez ile index belirterek.

AWS_SERVICES[0]="ec2"
AWS_SERVICES[1]="s3"
Dizi elemanlarına erişirken ise :

echo ${AWS_SERVICES[0]}
echo ${AWS_SERVICES[1]}
echo ${AWS_SERVICES[2]}
İkincisi: Normal parantez ile.

AWS_SERVICES=(“ec2”,”s3",”cloudformation”)

çağırırken hepsini getirtmek için

echo ${AWS_SERVICES[@]} >> @ işareti kullandık


Aritmetik İşlemler
Aritmetik işlemlerle ilgili de üç yöntem göstereceğim. Birincisi expr komutu, ikincisilet komutu sonucusu ise çift parantez.


expr komutunda iki kuralımız var. Birincisi değerler arasında boşluk olmalı diğeri tırnak içinde olmamalı.


Basit bir örnek yapalım aşağıda gördüğünüz script üzerinden konuşalım.

#!/bin/bash
read -p "birinci sayıyı giriniz: " ilk_sayi
read -p "ikinci sayıyı giriniz: " ikinci_sayi
read -p "aritmetik işlemi giriniz: " art_islem
if [[ art_islem = "+" ]]
        toplam=$(expr $ilk_sayi + $ikinci_sayi)
then
        echo $toplam
fi
Basit bir hesap makinası yaptığımızı farzedelim. if yapısını henüz anlatmadım o kısmı görmezden gelelim. read komutunu -p parametresiyle kullanıcıdan iki sayı ve aritmetik operatoru aldık. aritmetik işlem için expr komutunu kullandık.

Aritmetik işlemler için kullancağımız ikinci komutumuz let . let komutu bash içerisinde built-in fonksiyondur. expr komutundan farklı olarak tırnakları kullanırız. Tırnak kullanmaz isek arada boşluk kullanmamamız gerekir.

let "toplam = 10 +5"

let toplam=10+5

echo $toplam

Üçüncü yöntem olan çift parantaze geçelim. Burda let veya expr komutu kullanmamıza gerek yok yapacağımız işlemi çift parantez içine alacağız.

toplam=$(($ilk_sayi + $ikinci_sayi))

Son olarak artırma ve azaltma operatorlerinden bahsedip aritmetik işlemleri bitireceğiz.

deger=5

let yeni_deger=deger++

echo $yeni_deger

Yukarıdaki durumda yeni_deger degişkenine deger değişkenini atadıktan sonra artırma gerçekleşir yani burumda yeni_deger 5 olarak kalır.

deger=5

let yeni_deger=++deger

echo $yeni_deger

Bu yeni_deger degişkenine deger değişkenini artırıldıktan sonra atma gerçeklerşir.B urumda yeni_deger 6 olur.

Koşullar
Herhangi bir programlama diliyle aynı mantıkta çalışır sadece syntax’ı biraz farklıdır. Bu başlıkta if ve case yapısını göreceğiz. Girintiler(indentation) önemli değildir Bu yapıyı görmeden önce karşılaştırma operatorlerini görelim.

Karşılaştırma Operatörleri
Sayısal değerler için:
-eq >> equal

-ne >> not equal

-gt >> greater than

-lt >> less than

-ge >> greater than or equal

-le >> less than or equal

String değerler için:
= >> equal

!= >> not equal

-z >> Empty string

-n >> Not empty string

Dosya işlemleri için:
-d file >> directory

-e file >> exists

-f file >> ordinary file

-r file >> readable

-s file >> size is > 0 bytes

-w file >> writable

-x file >> executable

if Yapısı
Şimdi yapısını inceleyelim;

if [[ <koşul> ]]
then
  <komutlar>
elif [[ <koşul> ][
then
	<komutlar>
else
	<komutlar>
fi
Şimdi de basitten zora küçük örmekler yapalım. aklimda değişkenine bir değer atayıp kullanıcıdan da bir değer girmesini bekleyeceğiz öncelikle eşit mi? daha sonra eşit mi değil mi? en sonunda da büyük küçük gibi ilaveler yapacağız.

#!/bin/bash
aklimda=10
read -p "haydi tahmin yap: " tahmin
if [[ $aklimda = $tahmin ]]
then
        echo "TEBRİKLER"
fi

Yukarıdaki scriptte sadece if koşulu var doğru ise sonuç alırız yanlış ise herhengi bir dönüş olmaz.

#!/bin/bash
aklimda=10
read -p "haydi tahmin yap: " tahmin
if [[ $aklimda = $tahmin ]]
then
        echo "TEBRİKLER"
else
        echo "YANLIŞ CEVAP DOĞRUSU $aklimda OLACAKTI"
fi

Yukarıdaki scriptte else yapısı örneğini gördük if koşulu gerçekleşmez ise else komutu çalışacak

#!/bin/bash
aklimda=10
read -p "haydi tahmin yap: " tahmin
if [[ $aklimda = $tahmin ]]
then
        echo "TEBRİKLER"
elif [[ $aklimda -gt $tahmin ]]
then
        echo "AKLIMDAKİ SAYI $aklimda TAHMİNİNDEN $tahmin 'den büyük"
else
        echo "AKLIMDAKİ SAYI $aklimda TAHMİNİNDEN $tahmin 'den küçük"
fi

case Yapısı
Yukarıda tam set yapıyı gördük elif ler ile koşul sayısını istediğimiz kadar artırırız. Fakat koşullar çok fazla olduğunda kodun okunurluluğunu zorlaşırtırır. Tam burada farklı bir yapı imdadımıza koşuyor.

Koşullar konusunda son yapımız case yapısı. Her seçenek için bir komut yazıyoruz. Yapı aşağıdaki gibi.

case $secenek in
	"ilk_durum")
		  <komutlar>
	;;
	"ikinci_durum")
		  <komutlar>
	;;
	"üçüncü_durum")
		  <komutlar>
	;;
	*) # diğer tüm durumlar için.
		  <komutlar>
	;;
esac
Bir örnekle inceleyelim hesap makinasını case ile yapalım her operator durumu için yeni bir case oluşturalım.

#!/bin/bash
read -p "ilk sayıyı giriniz: " ilk_sayi
read -p "ikinci sayıyı giriniz: " ikinci_sayi
read -p "operator giriniz (+-*/ şeklinde) :" operator
case $operator in
        "+")
                echo "sonuc= $(( $ilk_sayi + ikinci_sayi))"
        ;;
        "-")
                echo "sonuc= $(( $ilk_sayi - ikinci_sayi))"
        ;;
        "*")
                echo "sonuc= $(( $ilk_sayi * ikinci_sayi))"
        ;;
        "/")
                echo "sonuc= $(( $ilk_sayi / ikinci_sayi))"
        ;;
        *)
                echo "hatalı değer girdiniz"
        ;;
esac

Bir örnek yapalım. Kullanıcıdan bir dosya ismi girmesini isteyelim.

1- Dosyanın okuma ve yazma izni varsa evet yazıp çıksın.

2- Yoksa dosyaya okuma yazma izni vereyim mi diye sorsun.

3- Evet ise işlemi yapsın okuma yazma izni versin

4- Hayır ise direk çıkış bye yazıp çıksın.

5- Yanlış kullanımlar için bye yazıp çıksın.

Not: Klasörde olan dosya olduğunu varsayıyoruz.

#!/bin/bash
  
read -p "file isimi girin: " file
if [[ -r $file ]] && [[ -w $file ]]
then
        echo "evet"
else
        read -p "readable writable yapayım mı evet or hayır gir: " evethayir
        if [[ $evethayir = "hayır" ]]
        then
                echo "bye"
        elif [[ $evethayir = "evet" ]]
        then
                chmod +wr $file
        else
                echo "bye"
        fi
fi
Döngüler
3 çeşit döngü yapısı mevcut. For, While ve Until. For ile başlayalım önce yapıyı görelim.

For döngüsü
for degisken in <liste>
do
 <komutlar>
done
Bir liste oluşturalım ve for döngüsü ile içindekileri yazdıralım.

#!/bin/bash
dizi=("bir" "iki" "üç" "dört")
for i in ${dizi[@]}
do
        echo " $i"
        echo "---"
done

Dizinin elamalarını tek tek yazdırmak için for döngüsü kullandık.

While Döngüsü
Önce formatı görelim

while [ <koşul> ]
do
  <komutlar>
done
Örnekle açıklayalım. Başlangıç için bir değeri değişkene atayalım her döngüde değişkenin değerini bir azaltalım ve komut olarak da iki katını yazdıralım.

#!/bin/bash
degisken=10
while [ $degisken -gt 0 ]
do
        echo $(( $degisken * 2 ))
        degisken=$(($degisken - 1))
done

Until
Önce yapıyı görelim. Daha sonra örnek yapalım. While’dan farkı şudur koşul yanlış olduğu sürece komutlar çalışır.

until [ <koşul> ]
do
  <komutlar>
done
Yine bir değişkene değer atayalım. Değişkenin modunu alalım ve her döngüde değerini 1 azaltalım.

Döngü değişken değeri 0 dan büyük olduğu sürece dönsün.

#!/bin/bash
degisken=5
until [  $degisken -lt 0 ]
do
        echo $(( $degisken % 2 ))
        degisken=$(($degisken - 1))
done

Döngülerde continue ve break komutları
continue komutu görüldüğünde koşul sağlanmış ise o adımı atla devam et demektir.

#!/bin/bash
for i in {0..10}
do
        if [[ $i -lt 3 ]]
        then
                continue
        else
                echo $i
        fi
done
0–10 arası sayıları yazdırmak istedik ama 3'ten küçükse yazdırma devam et şeklinde continue komutunu kullandık.


break ise koşul sağlanmışsa döngüyü orada kes devam etme anlamı vardır.

#!/bin/bash
for i in {0..10}
do
        if [[ $i -gt 5 ]]
        then
                break
        else
                echo $i
        fi
done
Burada da eğer sayı 5 ten büyükse döngüyü kır dedik.


