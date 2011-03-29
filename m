From: dilinger@queued.net (Andres Salomon)
Date: Mon, 28 Mar 2011 17:52:23 -0700
Subject: [PATCH resend] ARM: mx51_efika: fix build error due to new mfd
	changes
In-Reply-To: <AANLkTikLK+jbVhnrNVinhLDXZoozH-6VsjwjYLNwTdxU@mail.gmail.com>
References: <20110328172230.01756522@queued.net>
	<AANLkTikLK+jbVhnrNVinhLDXZoozH-6VsjwjYLNwTdxU@mail.gmail.com>
Message-ID: <20110328175223.52c86c0f@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Mar 2011 21:47:58 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Andres,
> 
> On Mon, Mar 28, 2011 at 9:22 PM, Andres Salomon <dilinger@queued.net>
> wrote:
> >
> > MFD changes in 4ec1b54c ('mfd: mfd_cell is now implicitly available
> > to mc13xxx drivers') changed the mc13xxx_platform_data struct
> > layout. At the time all users were changed, but this driver was
> > introduced in another tree at the same time. ?This updates the
> > mc13xxx_platform_data user, fixing a build error.
> >
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > ---
> > ?arch/arm/mach-mx5/mx51_efika.c | ? ?6 ++++--
> > ?1 files changed, 4 insertions(+), 2 deletions(-)
> 
> Your patch is in Sascha?s tree now:
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=251290a6078cb88382344b3ee535ae8c6254c1b5
> 
> Regards,
> 
> Fabio Estevam

Ah, thanks, I hadn't heard anything about it.  Linus, feel free to
ignore my patch.
