From: stigge@antcom.de (Roland Stigge)
Date: Fri, 23 Mar 2012 15:52:05 +0100
Subject: ioremap to a specific virtual address
In-Reply-To: <201203231407.00686.arnd@arndb.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203230023060.24151@xanadu.home>
 <CAKON4Ox6sp5YMryr2jzOAqYNmJG9RyahLTusrHZ_jcNQ40DAfQ@mail.gmail.com>
 <201203231407.00686.arnd@arndb.de>
Message-ID: <4F6C8E15.5050104@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 23/03/12 15:07, Arnd Bergmann wrote:
> I think you should work together with Roland Stigge, who is currently
> looking into doing the same for lpc32xx. My guess is that you can save
> a lot of work by combining your efforts, while you would get conflicting
> DT bindings if you don't. Note that Roland has done a lot of patches
> already for nxp device drivers that will be part of v3.4. He has not yet
> started on DT patches but wants to work on that for v3.5.

You wrote about NXP's BSP from 3 years ago. At git.lpclinux.com, you can
find lpc31xx's branches, updated only some weeks ago, based on Linux 2.6.33.

Feel free to join my efforts for DT on lpc32xx. Don't know how much
lpc31xx and lpc32xx have in common, and I currently don't have access to
an lpc31xx device. However, I will post patches for DT support on
lpc32xx, based on the patches I already have at git.antcom.de and
antcom.de/lpc32xx/ (some of which already go into v3.4).

Thanks,

Roland
