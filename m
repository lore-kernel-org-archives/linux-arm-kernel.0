From: b32955@freescale.com (Huang Shijie)
Date: Mon, 16 Apr 2012 13:48:41 +0800
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <CAOMZO5A1hO8O1Zr5R2929bA2LYrcKM0RySM4aSu0PkLU-Cmr_w@mail.gmail.com>
References: <4F77C9A6.6080601@freescale.com>	<20120402111240.GG19011@mudshark.cambridge.arm.com>	<4F7E646D.6000302@freescale.com>	<20120410092214.GA2620@mudshark.cambridge.arm.com>	<4F840BDC.5060307@freescale.com>	<4F854992.9080601@freescale.com>	<20120411102437.GE16643@mudshark.cambridge.arm.com>
 <CAOMZO5A1hO8O1Zr5R2929bA2LYrcKM0RySM4aSu0PkLU-Cmr_w@mail.gmail.com>
Message-ID: <4F8BB2B9.3050202@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?04?11? 19:02, Fabio Estevam ??:
> On Wed, Apr 11, 2012 at 7:24 AM, Will Deacon<will.deacon@arm.com>  wrote:
>
>>> I wish i could find a more common test case to reproduce this bug. But, i can't.
>>> The only test case now is to run the gplay on our IMX6Q platform.
>> Ok, that makes it tricky since I don't have gplay or an IMX6Q platform.
> gplay is a C application that does the same thing as launching a
> simple Gstreamer pipeline like:
>
> gst-launch playbin2 uri=file:///home/file.mp4
>
> Huang,
>
> Does the problem also occur if you don?t use the VPU driver? I mean,
I do not test the case with the VPU disabled.
> does it also happen if you decode the file using software codecs. I
> would like to know if the issue you see is related to the VPU driver
Can the vpu affects the futex?  I  am debugging an uart bug now.
I will continue to debug this bug when i finish the uart bug.

Best Regards
Huang Shijie
> or not.
>
