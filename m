From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 08:02:27 -0300
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <20120411102437.GE16643@mudshark.cambridge.arm.com>
References: <4F77C9A6.6080601@freescale.com>
 <20120402111240.GG19011@mudshark.cambridge.arm.com>
 <4F7E646D.6000302@freescale.com>
 <20120410092214.GA2620@mudshark.cambridge.arm.com>
 <4F840BDC.5060307@freescale.com> <4F854992.9080601@freescale.com>
 <20120411102437.GE16643@mudshark.cambridge.arm.com>
Message-ID: <CAOMZO5A1hO8O1Zr5R2929bA2LYrcKM0RySM4aSu0PkLU-Cmr_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 7:24 AM, Will Deacon <will.deacon@arm.com> wrote:

>> I wish i could find a more common test case to reproduce this bug. But, i can't.
>> The only test case now is to run the gplay on our IMX6Q platform.
>
> Ok, that makes it tricky since I don't have gplay or an IMX6Q platform.

gplay is a C application that does the same thing as launching a
simple Gstreamer pipeline like:

gst-launch playbin2 uri=file:///home/file.mp4

Huang,

Does the problem also occur if you don?t use the VPU driver? I mean,
does it also happen if you decode the file using software codecs. I
would like to know if the issue you see is related to the VPU driver
or not.
