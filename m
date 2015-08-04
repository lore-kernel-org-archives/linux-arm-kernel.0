From: horms@verge.net.au (Simon Horman)
Date: Tue, 4 Aug 2015 09:53:41 +0900
Subject: [PATCH v3] ARM: shmobile: silk: initial device tree
In-Reply-To: <55BF8522.1010906@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <2360526.88foRQAOiM@wasted.cogentembedded.com>
 <CAMuHMdWT=nzsFuM-vfe5GoAtDE-AtW4LAZoEnBGGVZm54-mAzg@mail.gmail.com>
 <55BF8522.1010906@cogentembedded.com>
Message-ID: <20150804005341.GB16257@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 06:13:38PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/03/2015 04:00 PM, Geert Uytterhoeven wrote:
> 
> >>--- /dev/null
> >>+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
> >>@@ -0,0 +1,51 @@
> 
> >>+/ {
> >>+       model = "SILK";
> >>+       compatible = "renesas,silk", "renesas,r8a7794";
> 
> >WARNING: DT compatible string "renesas,silk" appears un-documented --
> >check ./Documentation/devicetree/bindings/
> 
> >Do you plan to update Documentation/devicetree/bindings/arm/shmobile.txt?
> 
>    No, I had no idea I should record the board names somewhere too...

Sergei, please submit a parch as suggested by Geert.
