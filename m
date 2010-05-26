From: slapinid@gmail.com (Sergey Lapin)
Date: Wed, 26 May 2010 16:13:46 +0400
Subject: 18bpp display on OMAP3
In-Reply-To: <667948.10985.qm@web29003.mail.ird.yahoo.com>
References: <667948.10985.qm@web29003.mail.ird.yahoo.com>
Message-ID: <AANLkTil51--JWYMBRxbkf8DQFxAJc_DDIlwhnLdgLCJ3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 4:00 PM, Patrick <kpa_info@yahoo.fr> wrote:
> Hello all,
>
> I am currently designing a new board based on OMAP3530 (Gumstix) with a 18bpp touchscreen. According to the Ti Technical Ref. Manual (page 2164) the Display controller support two packing mode: the "Loosely Packed" that use 24bits buts only the 6 MSB bits of each color and the "Packed" mode that compact?all the 18bpp.
>
> I would like to know which mode is recommended to use depending on the fb driver and eventually on the POWERVR SGX driver.
>
> Thanks in advance for your help
Packed 18bpp will require patching of Xorg and pixman. It is quite easy though.
Probably if no other problems, I'd prefer using loosely packed 24-bits
18-bit depth,
if using X11.
