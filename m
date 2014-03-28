From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 18:39:58 +0000
Subject: [PATCH 00/75] l2c series - Olof's boot failures
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <20140328183958.GP7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:12:49PM +0000, Russell King - ARM Linux wrote:
> This is another posting of the L2 cache controller series.  I'm not
> planning for this for the upcoming merge window, but the one after,
> as people need to test it and still need to feed back to me on
> various issues.  Hence, this is not a finalised series.
> 
> There are still various issues which I've raised, and have had no
> feedback on.

Olof's builder shows failures with this for:

    capri        multi_v7_defconfig            :        FAILED  1:03.10
    seaboard     tegra_defconfig               :        FAILED  1:29.70
    seaboard     multi_v7_defconfig            :        FAILED  1:26.35

I have no way to debug these failures.

However, strangely:

    capri        bcm_defconfig                 :        passed  0:42.83


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
