From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Nov 2016 11:05:44 +0000
Subject: [PATCH next] arm64: remove "SMP: Total of %d processors
 activated." message
In-Reply-To: <20161118101826.GC13470@arm.com>
References: <1479367946-38771-1-git-send-email-wangkefeng.wang@huawei.com>
 <20161117142213.GI22855@arm.com>
 <6d867f8f-c7b9-42e9-1764-6f802d6b1e96@huawei.com>
 <20161118101826.GC13470@arm.com>
Message-ID: <20161119110544.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 10:18:26AM +0000, Will Deacon wrote:
> On Fri, Nov 18, 2016 at 11:37:10AM +0800, Kefeng Wang wrote:
> > The message provides no further information than the generic code, so kill it.
> > Or show BogoMIPS like arm32?
> 
> Ha! No, I don't think printing the BogoMIPS is the right solution. I just
> think that, if you insist on removing the harmless print, then you should
> also consider doing the same thing for all the other architectures that
> print the same message.

Note that I'd removed the redundant message from ARM a long time ago,
until Linus reverted the patch due to the /proc/cpuinfo part.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
