From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Dec 2010 14:07:25 -0800
Subject: [PATCH v8 10/11] OMAP: GPIO: Implement GPIO as a platform device
In-Reply-To: <AANLkTikPey17e6wTHJ2zq8N=r_pNKXV4YjVbTK5e+tYt@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1290689318-10191-11-git-send-email-charu@ti.com>
	<AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
	<AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
	<AANLkTikPey17e6wTHJ2zq8N=r_pNKXV4YjVbTK5e+tYt@mail.gmail.com>
Message-ID: <20101207220725.GB17435@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Varadarajan, Charulatha <charu@ti.com> [101206 22:58]:
> On Tue, Dec 7, 2010 at 11:05, Varadarajan, Charulatha <charu@ti.com> wrote:
> >
> > On Tue, Dec 7, 2010 at 10:49, Cory Maccarrone <darkstar6262@gmail.com> wrote:
> >>
> >> ? ?omap_gpio omap_gpio.5: Could not get gpio dbck
> >> ? ?omap_gpio omap_gpio.6: Could not get gpio dbck
> >>
> >> I think that 'if' should be:
> >>
> >> ? ?if (bank->dbck_flag && !bank->dbck) {
> >
> > You are right. Will send a patch now.

Looks like if that's a warning no need to merge it into the
earlier patches.

Tony
