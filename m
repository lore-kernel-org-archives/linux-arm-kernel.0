From: henryp@broadcom.com (Henry Ptasinski)
Date: Sat, 7 May 2011 15:42:25 -0700
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <4DC5805C.2010202@hauke-m.de>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<4DC56FB9.5000208@hauke-m.de>
	<BANLkTi=FfjK7obq0hj4TjYZc-GgzTuUC6g@mail.gmail.com>
	<4DC57425.30206@hauke-m.de>
	<BANLkTikTarvigU-xZNZikhLyvUWse448Tg@mail.gmail.com>
	<4DC5805C.2010202@hauke-m.de>
Message-ID: <20110507224223.GA2537@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 07, 2011 at 10:24:44AM -0700, Hauke Mehrtens wrote:
> On 05/07/2011 06:51 PM, Rafa? Mi?ecki wrote:
> > 2011/5/7 Hauke Mehrtens <hauke@hauke-m.de>:
> >> There is a Ethernet core used on embedded devices with this bus and
> >> George wrote a driver for the first version of this bus implementation,
> >> he send to the ML. Most user will use this with some wireless devices so
> >> I would add linux-wireless at vger.kernel.org. Why does ssb uses netdev ML?
> > 
> > Thanks, I didn't know about this ethernet driver. Have to check it!
> > Where was this published? Do you have a thread name?
> 
> I think he haven't send it to the mailing list, there is a link [0] in
> some Ticket [1] at OpenWrt. This driver was derived from source code
> Braodcom have published, but not under a GPL compatible license. It will
> be nice if Braodcom would allow us to publish a driver under the terms
> of the GPL for the Ethernet core based on their driver, without writing
> a full spec of the driver like it was done for b43.

...
> 
> [0] http://www.znau.edu.ua/temp/asus-rt-n16/openwrt-bcm4716-README.txt
> [1] https://dev.openwrt.org/ticket/6580#comment

All of of the patches listed in [0] appear to contain GPL-licensed code.  Can
you provide a pointer to the ethernet driver that you think is not under a
GPL-compatible license?

Thanks,
---
Henry Ptasinski
henryp at broadcom.com
