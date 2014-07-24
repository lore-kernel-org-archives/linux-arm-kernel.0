From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 24 Jul 2014 16:24:49 -0700
Subject: [PATCH v2 04/11] ARM: dts: zynq: Update deprecated xuartps clock
 names
In-Reply-To: <53D1931C.7080409@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-5-git-send-email-afaerber@suse.de>
 <82ab6426-211e-451e-99c3-df40dbea817e@BN1AFFO11FD039.protection.gbl>
 <53D1931C.7080409@suse.de>
Message-ID: <50aad941-92d9-428a-a708-77040e24b651@BY2FFO11FD008.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 01:13AM +0200, Andreas F?rber wrote:
> Am 25.07.2014 01:09, schrieb S?ren Brinkmann:
> > On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
> >> Avoids deprecation warning messages.
> > 
> > A patch that updates those names is already in armsoc.
> 
> Which tree/branch should I base this series on then? It seemed the
> Xilinx branches were all heavily outdated some days ago, so this is
> against vanilla v3.16-rc6.

That is something for the maintainers to answer. But in general, you're
adding a lot of stuff that is not yet upstream, AFAIK. Some is still
under review I think (like QSPI), others are just staged for the next
merge window and parts are still in flight. Michal hopefully has a
better overview.
This particular patch can simply be omitted I think.

	S?ren
