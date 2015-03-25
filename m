From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 25 Mar 2015 21:20:00 +0100 (CET)
Subject: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
In-Reply-To: <201503242145.26370.juergen@kreuzholzen.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-8-git-send-email-stefan.wahren@i2se.com>
 <201503242145.26370.juergen@kreuzholzen.de>
Message-ID: <295486259.670501.1427314800804.JavaMail.open-xchange@oxbaltgw09.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juergen,

> Juergen Borleis <juergen@kreuzholzen.de> hat am 24. M?rz 2015 um 21:45
> geschrieben:
>
>
> Stefan Wahren wrote:
> > [...]
> 
> Maybe you should take into account not to reduce VDD below 1.55 V if the SDRAM
> controller runs above 196 MHz. The i.MX28 datasheet[1] lists these
> restrictions. VDD powers the SDRAM controller as well. From the datasheet the
> table "Frequency versus Voltage for EMICLK" shows:
>
> EMICLK Fmax (MHz)
> VDDD (V) DDR2 mDDR
> --------------------------------
> 1.550 205.71 205.71
> 1.450 196.36 196.36
> 1.350 196.36 196.36
>
> jbe
>
> [1]
> i.MX28 Applications
> Processors for Consumer
> Products
> Silicon Version 1.2
>
> Document Number: IMX28CEC
> Rev. 3, 07/2012

thanks for pointing out. I will take care of it.

Stefan
