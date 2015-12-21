From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Dec 2015 09:11:10 +0000
Subject: [PATCH v3 4/4] drivers: psci: replace psci firmware calls
In-Reply-To: <20151216134740.GB22916@red-moon>
References: <1448449461-5043-1-git-send-email-jens.wiklander@linaro.org>
 <1448449461-5043-5-git-send-email-jens.wiklander@linaro.org>
 <20151201184741.GE29045@leverpostej> <20151201194421.GA29068@ermac>
 <20151216105529.GC19814@red-moon> <20151216125509.GA27585@ermac>
 <20151216134740.GB22916@red-moon>
Message-ID: <20151221091110.GV8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 01:47:40PM +0000, Lorenzo Pieralisi wrote:
> It is really up to Daniel and Russell. If Daniel acks:
> 
> https://patchwork.kernel.org/patch/7418351/
> 
> I can easily rebase it and send it to RMK patch system (as things stand
> it seems the easier option), otherwise the merge conflict (which will show
> up in -next anyway) has to be sorted out, I am open to suggestions.

I notice that no one has acked or apparently reviewd the first patch at
all.  It would be good to get something on that.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
