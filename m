From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 21 Jan 2016 10:14:37 +0100
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <569052FE.1040008@gmail.com>
References: <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
 <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
 <20160108075913.GN11364@pali> <569052FE.1040008@gmail.com>
Message-ID: <20160121091437.GT7192@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 January 2016 02:23:26 Ivaylo Dimitrov wrote:
> Hi,
> 
> On  8.01.2016 09:59, Pali Roh?r wrote:
> >On Friday 08 January 2016 07:13:58 Ivaylo Dimitrov wrote:
> >>And it looks like the problems happens sometimes on oops too.
> >
> >In linux-n900 tree is enabled mtdoops driver which store oops to
> >specified MTD device. So maybe this access cause it?
> >
> 
> The key word here is "sometimes". i.e sometimes it hapens on normal reboot,
> sometimes it happens on oops.

So where is problem? In omap-gpmc? mtd? onenand? or ubifs? Or in
different component? Do we know at least this?

-- 
Pali Roh?r
pali.rohar at gmail.com
