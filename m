From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 4 Mar 2015 14:05:25 +0100
Subject: [PATCH 07/10] pinctrl: mvebu: add pinctrl driver for Marvell
 Armada 39x
In-Reply-To: <CACRpkdZH9vUPR65Yw65LKHns8_b3vM+1ARoks2j73WV2WmAExQ@mail.gmail.com>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdZH9vUPR65Yw65LKHns8_b3vM+1ARoks2j73WV2WmAExQ@mail.gmail.com>
Message-ID: <20150304140525.711d1515@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

On Wed, 4 Mar 2015 13:54:42 +0100, Linus Walleij wrote:
> On Fri, Feb 6, 2015 at 4:57 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> 
> > This commit adds a new pinctrl driver for the Marvell Armada 39x
> > family of processors, which hooks into the existing infrastructure to
> > support pin-muxing on Marvell EBU processors. Two variants of the
> > Armada 39x are supported: 88F6920 (Armada 390) and 88F6928 (Armada
> > 398), which have a few differences in the available functions for
> > certain pins.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Patch applied.

I'm surprised you applied the driver of the first iteration of the
patches, and not the v3 I sent just yesterday. Even though if I
remember correctly there were no changes on the pinctrl driver itself.

Also, can you apply:

  devicetree: bindings: add Device Tree bindings for Armada 39x pin-muxing controller

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
