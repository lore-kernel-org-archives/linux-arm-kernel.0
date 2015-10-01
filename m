From: codekipper@gmail.com (Code Kipper)
Date: Thu, 1 Oct 2015 14:54:07 +0200
Subject: [linux-sunxi][PATCH v5] ARM: sun7i: dt: Add new Olimex A20 EVB
 device
In-Reply-To: <20151001120630.GH7104@lukather>
References: <1443634479-18111-1-git-send-email-codekipper@gmail.com>
 <20151001120630.GH7104@lukather>
Message-ID: <CAEKpxB=ytV17o5uO6srDbJSrvNe66EeRERF-Ow=HuzE4=z1qag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +&reg_dcdc2 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1000000>;
>> +     regulator-max-microvolt = <1425000>;
>
> You also changed that since v4, for an unknown reason, and without
> mentionning it in the changelog...
AAARRRGGGGHHHHHHHHHHH....could you kindly fix this for me?....pllllleeeasseee.
CK
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
