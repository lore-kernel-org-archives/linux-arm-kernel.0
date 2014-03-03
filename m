From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Mar 2014 09:54:41 +0100
Subject: linux-next: manual merge of the akpm-current tree with the
 arm-soc tree
In-Reply-To: <20140303190152.8b87330c0d83679b10c5ca5a@canb.auug.org.au>
References: <20140303190152.8b87330c0d83679b10c5ca5a@canb.auug.org.au>
Message-ID: <20140303085441.GW6865@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 07:01:52PM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> Today's linux-next merge of the akpm-current tree got a conflict in
> arch/arm/mach-vexpress/Kconfig between commit 9352b05b6e4e ("ARM: select
> MIGHT_HAVE_CACHE_L2X0 for V6 and V7 multi-platform") from the arm-soc
> tree and commit b096b0b50c4b ("Kconfig: rename HAS_IOPORT to
> HAS_IOPORT_MAP") from the akpm-current tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
your resolution and the two earlier ones from today[1] all look right

Best regards
Uwe

[1] The conflicts with

	ddb902cc3459 ("ARM: centralize common multi-platform kconfig options")
	9352b05b6e4e ("ARM: select MIGHT_HAVE_CACHE_L2X0 for V6 and V7 multi-platform")

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
