From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Oct 2009 20:20:23 +0200
Subject: [PATCH] at91: support for eco920
In-Reply-To: <20091023175629.GB29430@game.jcrosoft.org>
References: <20091021084826.GA29667@n2100.arm.linux.org.uk>
	<1256115527-20635-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091021151917.GE19714@game.jcrosoft.org>
	<20091023121152.GB1821@pengutronix.de>
	<20091023175629.GB29430@game.jcrosoft.org>
Message-ID: <20091023182023.GB3440@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 07:56:29PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:11 Fri 23 Oct     , Uwe Kleine-K?nig wrote:
> > On Wed, Oct 21, 2009 at 05:19:17PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 10:58 Wed 21 Oct     , Uwe Kleine-K?nig wrote:
> > > > CONFIG_MACH_ECO920 is enabled in at91rm9200dk_defconfig.  The name is
> > > > wrong, but this is better than adding another defconfig or don't get
> > > > compile coverage at all./
> > > in this case it will be better to have a generic rm9200 defconfig
> > right, but imho this shouldn't stop my patch.
> rename at91rm9200dk_defconfig to at91rm9200_defconfig will make the patch
> better and will avoid this comment about wrong name defconfig
Hm, this is only slightly better:

	linux-2.6$ grep CONFIG_ARCH_AT91RM9200=y arch/arm/configs/* | wc -l
	12

Andrew, thoughts?  Are you interested at all in reducing the number of
defconfigs for at91?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
