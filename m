From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 20:42:26 +0100
Subject: [PATCH 35/38] mmc: dw_mmc: call mmc_of_parse to fill in common
 options
In-Reply-To: <53585B7A.3@samsung.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
 <E1Wd2Xd-0003we-7P@rmk-PC.arm.linux.org.uk> <53585B7A.3@samsung.com>
Message-ID: <20140424194226.GD26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 09:31:54AM +0900, Jaehoon Chung wrote:
> Dear, Russell.
> 
> I didn't know which version you have checked.

As I said in the cover, this series is based on v3.15-rc1.  It's
based there because it's part of a much larger set of patches that
need to be based on a common point in order to generate a series of
around 230 patches against a mainline kernel version.

> But I have known that mmc_of_parse() have already included at
> mmc-next repository.

That's partly good news, but only partly because I raised issues with
Olof's patches which were silently ignored - you'll notice that patch
36 reworks Olof's patch (my patch 34) in such a way that other hosts
(eg, sdhci) can make use of it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
