From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Jun 2016 10:39:33 -0700
Subject: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
In-Reply-To: <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
Message-ID: <20160602173932.GF5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [160602 10:39]:
> On Thu, Jun 2, 2016 at 2:41 AM, Yong Li <yong.b.li@intel.com> wrote:
> 
> > From: Yong Li <sdliyong@gmail.com>
> >
> > Without this patch, I2C-1 is missing on beaglebone black boards
> >
> > Signed-off-by: Yong Li <sdliyong@gmail.com>
> > ---
> >  arch/arm/boot/dts/am335x-boneblack.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> 
> 
> This is also 'common' for the white/green, if your really going to push
> this, please add it to:
> 
> am335x-bone-common.dtsi

But isn't this exposed on the cape pins? So the use can be
whatever for these pins?

Tony
