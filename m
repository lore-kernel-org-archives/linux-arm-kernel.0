From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Jun 2013 00:02:04 -0700
Subject: [PATCH] ARM: multi_v7: Add OMAP with ramdisk config bits
In-Reply-To: <51C858B4.2020106@ti.com>
References: <1371071282-14750-1-git-send-email-santosh.shilimkar@ti.com>
 <20130618082422.GE5523@atomide.com> <51C07253.3040909@ti.com>
 <51C858B4.2020106@ti.com>
Message-ID: <20130625070203.GA5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [130624 07:39]:
> Hi,
> On Tuesday 18 June 2013 08:14 PM, Santosh Shilimkar wrote:
> > On Tuesday 18 June 2013 04:24 AM, Tony Lindgren wrote:
> >> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130612 14:14]:
> >>> Add ramdisk fileystem related options which lets OMAP5 and Keystone
> >>> SOCs to boot till shell with multi_v7_config.
> >> Please add also other v7 omaps.
> >>
> > Should have done first place. Sorry.
> > Will update other machines and after testing, repost it.
> >
> > Regards,
> > Santosh
> >
>  Since CONFIG_ARCH_OMAP2PLUS=y is set in the patch,
>  OMAP3, OMAP4 are getting enabled by default.
> 
>  I tested OMAP4 PANDA on mainline + multi_v7_config + above patch
>  and it booted up fine.

OK thanks for testing. Those default y things will be going
away, but we can update both defconfigs after that.

Acked-by: Tony Lindgren <tony@atomide.com>
