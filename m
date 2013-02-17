From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 17 Feb 2013 15:44:44 +0800
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <CAOMZO5B2yQv+HBnq8C1RE+LD1Lj-DGa3-iJ=yjG5xKKpNK4x7w@mail.gmail.com>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
 <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
 <201302100428.54061.marex@denx.de>
 <CAOMZO5B2yQv+HBnq8C1RE+LD1Lj-DGa3-iJ=yjG5xKKpNK4x7w@mail.gmail.com>
Message-ID: <20130217074443.GC15048@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 02:26:11PM -0200, Fabio Estevam wrote:
> On Sun, Feb 10, 2013 at 1:28 AM, Marek Vasut <marex@denx.de> wrote:
> 
> > Is the amba-pl011 driver maybe broken ?
> 
> At least on mx28evk, ttyAMA0 is not getting registered when running linux-next.
> 
> I haven't had a chance to debug it though.

Try reverting commit aac73f3 (of: use platform_device_add) and see if it
helps.

Shawn
