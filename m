From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 19 Jun 2012 10:17:19 +0100
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
 <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com>
Message-ID: <20120619091719.GZ3974@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 12:25:58PM +0800, Wei Ni wrote:

As Stephen previously said please fix your mail formatting - word
wrapping within paragraphs is important!

> On Tue, Jun 19, 2012 at 09:23:35, Philip Rakity wrote:
> >Why can't you use the regulator notify to get called back on power or 
> >voltage change options to plumb in the manipulation of the gpio. I can 
> >imagine you might need to add a notify call in core.c if you need to 
> >assert the gpio before power is applied
> 
> Yes, we can use the regulator notify, but the Tegra30 support is via
> device tree, I think there have no special board file to run the call
> back.

You can mix board files with device tree for cases where device tree is
not yet up to the job, though the goal should be to come up with a way
of expressing things in device tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120619/738ceb54/attachment.sig>
