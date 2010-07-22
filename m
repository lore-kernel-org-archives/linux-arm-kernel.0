From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 22 Jul 2010 14:07:42 +0300
Subject: [PATCH] Add support for Vista Silicon Visstrim_m10 board [v4].
In-Reply-To: <AANLkTimnAfDAmW8YO0PrAnTfgnTaMqqEad8JiBHfA0Vs@mail.gmail.com>
References: <1279795652-6175-1-git-send-email-javier.martin@vista-silicon.com>
	<AANLkTimnAfDAmW8YO0PrAnTfgnTaMqqEad8JiBHfA0Vs@mail.gmail.com>
Message-ID: <20100722110742.GD12359@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Thu, Jul 22, 2010 at 12:52:30PM +0200, Eric Miao wrote:
> On Thu, Jul 22, 2010 at 12:47 PM, Javier Martin
> <javier.martin@vista-silicon.com> wrote:
> > Vista Silicon Visstrim_m10 i.MX27 based board is used
> > as multimedia streaming server, access control and other
> > custom applications.
> >
> > Fixed some style issues.
> >
> > Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> > ---
> > ?arch/arm/mach-imx/Kconfig ? ? ? ? ? ? ? ? ? | ? ?9 +
> > ?arch/arm/mach-imx/Makefile ? ? ? ? ? ? ? ? ?| ? ?1 +
> > ?arch/arm/mach-imx/mach-imx27_visstrim_m10.c | ?265 +++++++++++++++++++++++++++
> 
> Mmm... I don't have this directory in my git tip.

It's in the imx-for-2.6.36 branch of Sascha 
(git://git.pengutronix.de/git/imx/linux-2.6.git).

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
