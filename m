From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 3 Aug 2015 18:13:38 +0300
Subject: [PATCH v3] ARM: shmobile: silk: initial device tree
In-Reply-To: <CAMuHMdWT=nzsFuM-vfe5GoAtDE-AtW4LAZoEnBGGVZm54-mAzg@mail.gmail.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <2360526.88foRQAOiM@wasted.cogentembedded.com>
 <CAMuHMdWT=nzsFuM-vfe5GoAtDE-AtW4LAZoEnBGGVZm54-mAzg@mail.gmail.com>
Message-ID: <55BF8522.1010906@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/03/2015 04:00 PM, Geert Uytterhoeven wrote:

>> --- /dev/null
>> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
>> @@ -0,0 +1,51 @@

>> +/ {
>> +       model = "SILK";
>> +       compatible = "renesas,silk", "renesas,r8a7794";

> WARNING: DT compatible string "renesas,silk" appears un-documented --
> check ./Documentation/devicetree/bindings/

> Do you plan to update Documentation/devicetree/bindings/arm/shmobile.txt?

    No, I had no idea I should record the board names somewhere too...

> Thanks!

> Gr{oetje,eeting}s,

>                          Geert

MBR, Sergei
