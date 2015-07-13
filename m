From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jul 2015 00:27:51 -0700
Subject: [PATCH v3 0/3] ARM: OMAP2+: wkup_m3_rproc support patches
In-Reply-To: <20150713072529.GD26485@atomide.com>
References: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
 <559ED0AB.4020703@ti.com> <20150713072529.GD26485@atomide.com>
Message-ID: <20150713072750.GE26485@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150713 00:28]:
> * Dave Gerlach <d-gerlach@ti.com> [150709 12:53]:
> > Tony,
> > On 04/01/2015 02:47 PM, Dave Gerlach wrote:
> > > This series adds the mach-omap2 code and DT nodes for v3 of the
> > > wkup_m3_rproc driver submitted here [1]. pdata-quirks patch requires
> > > the pdata added with patch 4 of the aforementioned series. Based on
> > > previous discussion here [2], the wkup_m3 DT node has been moved as a
> > > child of the l4_wkup as is done for l4_wkup components in Tero Kristo's
> > > series "PRCM+SCM cleanup against 4.0-rc1" found here [3]. Because of that,
> > > this series applies cleanly on top of that series in order to leverage the
> > > l4_wkup parent node introduced there.
> > > 
> > > In addition to the move of the wkup_m3 node for am33xx, a new patch
> > > has been added to introduce the wkup_m3 node in the same fashion for
> > > am43xx as both SoCs use the same configuration. With this change
> > > support was also added to pdata-quirks for passing reset handlers to
> > > the driver for the am43xx binding as was already done for am33xx.
> > > 
> > > I have pushed a branch containing all patches for am335x suspend
> > > here for a big picture view of how all patches fit together with
> > > these wkup_m3_rproc series [4].
> > > 
> > > v2->v3:
> > > -Change ti,am3353-wkup-m3 compat to ti,am3352-wkup-m3 to reflect
> > >  binding documentation change
> > > -Add ti,am4372-wkup-m3 node to am4372 SoC dt file
> > > -Add am4372 support to pdata-quirks for reset handlers
> > 
> > Now that Ohad has sent a pull request for the wkup_m3_rproc driver [1] and it
> > has been merged is it possible for this series with the DT nodes and pdata-quirk
> > to get picked up? Let me know and I can rebase and resend if you'd like.
> 
> Yes this series looks good to me now, will queue for v4.3.

Looks like you need to repost this series again against v4.2-rc2 
to apply though.
 
Regards,

Tony
 
> > [1] https://lkml.org/lkml/2015/7/1/354
