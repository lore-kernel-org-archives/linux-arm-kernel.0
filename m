From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 Jun 2016 15:16:30 +0300
Subject: [PATCH 13/13] ARM: dts: blanche: add Ethernet support
In-Reply-To: <CAMuHMdU2P6VKXNpEHGOKpyuM45Pk0CuHWngxwu5AYGqYfduXXg@mail.gmail.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1669958.qjJ7i3NBPv@wasted.cogentembedded.com>
 <CAMuHMdU2P6VKXNpEHGOKpyuM45Pk0CuHWngxwu5AYGqYfduXXg@mail.gmail.com>
Message-ID: <a60346f2-2abb-342b-dd20-38d401c4ceb3@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 6/1/2016 11:22 AM, Geert Uytterhoeven wrote:

>> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
>> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>
>> +       ethernet at 18000000 {
>> +               compatible = "smsc,lan89218", "smsc,lan9115";
>
> The "smsc,lan89218" needs to be documented in the device tree bindings.

    Have you looked at those bindings?

> Google couldn't find any evidence you submitted a patch for that.

    Because the bindings document *any* LAN9115 compatible chip already.

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
