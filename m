From: nickpelling@nanodome.com (Nick Pelling)
Date: Tue, 22 Feb 2011 22:54:56 +0000
Subject: SAMSUNG: any example code for soc_camera, tv output,
  etc...?
In-Reply-To: <AANLkTin0PR3VQLruade+w6GbCMoW9pXy4Kvn-sBZ+LBM@mail.gmail.c
 om>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk>
	<017901cbce9b$7b405ee0$71c11ca0$%kim@samsung.com>
	<20110217140621.GC24989@n2100.arm.linux.org.uk>
	<01b001cbcef7$3e7f5f90$bb7e1eb0$%kim@samsung.com>
	<9f2nkr$9lh756@out1.ip04ir2.opaltelecom.net>
	<AANLkTin0PR3VQLruade+w6GbCMoW9pXy4Kvn-sBZ+LBM@mail.gmail.com>
Message-ID: <9fibsi$eahr36@out1.ip07ir2.opaltelecom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi yujinzhi,

At 22:00 22/02/2011 +0800, =?GB2312?B?0+C999bH?= wrote:
>I have port a embeded linux system on my board based on EP9315, with
>support for usb video capture device, V4L2. Do you need V4L2 based on
>usb video capture device or other video/FM/AM controller on your
>board? If conveniently, can you provide more details about your
>project?

It's a tiny S5PC100 board with an Aptina MT9M131 (1.3MP) sensor and 
video out for some security camera projects I'm working on. I've just 
brought up another embedded V4L2-based Linux camera, so V4L2 would be 
nice - in fact, there's already some Samsung s5p fimc code checked 
into the main tree, but it's far from clear (to me, at least) how to 
go about integrating image sensors with that to get V4L2 working.

>You MUST need the datasheet of S5PC100 on your board, and other
>peripheral device's datasheet, like dm9000 ethernet controller if not
>integrated in SoC, and schematic diagrams of your board.

Hardware datasheets I have plenty of, it's the supporting 
documentation on the s3c fb / s5p fimc devices / v4l2 host stuff that 
I'm missing. Not a lot in the Documentation/arm/Samsung* directories, 
for example. :-(

Cheers, ....Nick Pelling.... 
