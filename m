From: pan@nt.tu-darmstadt.de (Vladimir Pantelic)
Date: Mon, 31 May 2010 11:45:36 +0200
Subject: 18bpp display on OMAP3
In-Reply-To: <667948.10985.qm@web29003.mail.ird.yahoo.com>
References: <667948.10985.qm@web29003.mail.ird.yahoo.com>
Message-ID: <4C038540.1020401@nt.tu-darmstadt.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patrick wrote:
> Hello all,
>
> I am currently designing a new board based on OMAP3530 (Gumstix) with a 18bpp touchscreen. According to the Ti
> Technical Ref. Manual (page 2164) the Display controller support two packing mode: the "Loosely Packed" that use
> 24bits buts only the 6 MSB bits of each color and the "Packed" mode that compact all the 18bpp.
>
> I would like to know which mode is recommended to use depending on the fb driver and eventually on the POWERVR SGX
> driver.

only one of the modes (packed iirc) supports HW dithering in the DSS subsystem ...
