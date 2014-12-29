From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 29 Dec 2014 11:04:48 -0800
Subject: [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
In-Reply-To: <20141229181556.GA26926@amd>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
 <CANOLnON6rAQ2+jJEFDKseH2Htu6bqRkURDioGt7zp1Ze73f8Pw@mail.gmail.com>
 <CAGo_u6qO0ok+GBnm7SQtw6dJuwGN2OuP7CpKDEWawS3V2go4KA@mail.gmail.com>
 <20141229181556.GA26926@amd>
Message-ID: <20141229190448.GA27124@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 07:15:56PM +0100, Pavel Machek wrote:
> On Mon 2014-12-29 12:01:03, Nishanth Menon wrote:
> > On Mon, Dec 29, 2014 at 11:52 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> > > On Fri, Dec 26, 2014 at 2:34 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > >> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> > >> which can be used to determine the SoCs temperature. This patch provides
> > >> a DT based driver for the temperature sensor based on an older driver
> > >> written by Peter De Schrijver for the Nokia N900 and N9.
> > >
> > > The sensor looks like an earlier iteration of sensors used in newer
> > > OMAPs, which are already supported by maybe
> > > drivers/thermal/ti-soc-thermal/ , maybe it would make sense to update
> > > that driver instead?
> > 
> > Just to be clear - OMAP4 is the first time that the sensors were
> > reliable enough to be used.
> 
> When testing initial version of the patch, they seem to work very well
> in the omap3 case.
> 
Pavel,

can you look into the omap4 thermal driver to see if it can be used ?

Thanks,
Guenter
