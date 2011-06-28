From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Jun 2011 12:04:38 +0200
Subject: [PATCH V2 0/3] Add drivers/pwm and drivers/pwm/st_pwm.c
In-Reply-To: <201106271526.12848.arnd@arndb.de>
References: <cover.1306831238.git.viresh.kumar@st.com>
	<4E086590.8080100@st.com> <201106271526.12848.arnd@arndb.de>
Message-ID: <20110628100438.GI6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 03:26:12PM +0200, Arnd Bergmann wrote:
> On Monday 27 June 2011, viresh kumar wrote:
> > On 05/31/2011 02:21 PM, Viresh KUMAR wrote:
> > > This patchset adds drivers/pwm directory as suggested by Arnd Bergmann in
> > > following discussion:
> > > 
> > > http://comments.gmane.org/gmane.linux.ports.arm.kernel/118651
> > > 
> > > and also adds support for ST Microelectronics Pulse Width Modulator. This is
> > > currently used by ST's SPEAr platform and tested on the same.
> > > 
> > > Changes since V1:
> > >  - Moved driver to drivers/pwm/ directory from drivers/misc
> > >  - arch/arm/configs/spear3xx_defconfig updated accordingly.
> > > 
> > > Changes since earlier patchset:
> > >  - Moved driver to drivers/misc/ directory.
> > > 
> > > It was earlier reviewed as part of following patchset:
> > > "[PATCH V6 00/17] Adding devices support for all spear machines"
> > > 
> > > Viresh Kumar (3):
> > >   drivers/pwm st_pwm: Add support for ST's Pulse Width Modulator
> > >   SPEAr3xx: Add machine support for ST's PWM IP
> > >   SPEAr3xx: Update defconfig for ST's PWM
> >
> > Will you push this patchset through your tree or somebody else will do?
> 
> Good question. If Sascha is able to come up with the patch to introduce
> the generic layer, I think it would be good to have it go though him.

Just posted a rebased and documented series again. Let's see what
happens. The time seems good to finally get this into the kernel.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
