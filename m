From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 26 Apr 2016 18:25:23 +0200
Subject: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of
 the GRF
In-Reply-To: <CAJZ5v0gi_EBnL+M6iEAkgYHNkFQOG5OT=6fABQtvCyQY4=GcQQ@mail.gmail.com>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
 <3991738.xMQYlxyb28@phil>
 <CAJZ5v0gi_EBnL+M6iEAkgYHNkFQOG5OT=6fABQtvCyQY4=GcQQ@mail.gmail.com>
Message-ID: <15890066.zZg7hiMmi2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Am Mittwoch, 13. April 2016, 06:55:03 schrieb Rafael J. Wysocki:
> On Tue, Apr 12, 2016 at 4:23 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Am Donnerstag, 31. M?rz 2016, 15:48:42 schrieb Heiko Stuebner:
> >> IO-domain handling is part of the general register files, so should live
> >> under the grf directly. This change allows the grf to be a simple-mfd and
> >> the io-domains fetching the syscon regmap from that parent-node.
> >> 
> >> The old binding is of course preserved, though deprecated.
> >> 
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> Acked-by: Kevin Hilman <khilman@baylibre.com>
> >> Tested-by: David Wu <david.wu@rock-chips.com>
> > 
> > could you look into picking up this patch 1/5 please?
> > 
> > The others are to much interwined into other devicetree changes, so I'll
> > apply them for 4.8, but it would be nice if you could pick up this one for
> > 4.7 so the code change becomes available at 4.8-rc1
> 
> OK, I'll pick it up, but I'm traveling this week, so that'll take a
> few days more.

I just checked kernel/git/rafael/linux-pm.git and didn't find this patch there, 
so I guess it might be time for a ping ;-) .


Thanks
Heiko
