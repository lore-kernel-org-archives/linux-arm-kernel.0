From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2016 12:33:25 +0100
Subject: [PATCH 0/2] ARM: keystone: Enable CPU hotplug
In-Reply-To: <57031F5F.3020300@oracle.com>
References: <1459794543-4822-1-git-send-email-j-keerthy@ti.com>
 <57031F5F.3020300@oracle.com>
Message-ID: <20160405113325.GF19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 07:13:51PM -0700, santosh shilimkar wrote:
> On 4/4/2016 11:29 AM, Keerthy wrote:
> >Series enables CPU hotplug for K2HK. CPU Hotplug tested on
> >K2HK-EVM.
> >
> >It is on top of 4.6-rc2.
> >
> >Keerthy (2):
> >   keystone: dts: add psci command definition
> >   ARM: configs: keystone: Add CPU Hotplug related options
> >
> Looks fine to me. Will add it to the 4.7 queue. Thanks !!

Just to note that this is required to get CPU hotplug working with
the TI keystone2 skern implementation, which is different to the
uboot psci code.

Now that I've been able to upgrade my board to a recent uboot and
skern, I can add this:

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Now... if we could get the damn CPU fan under control, I might be
able to stand leaving the board powered on for longer, instead of
reaching for the power plug at the earliest possibility!

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
