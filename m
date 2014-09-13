From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Sep 2014 23:00:57 +0100
Subject: [PATCH] arm: add missing exports for asm functions required by
 get_user macro
In-Reply-To: <1410637161-4865-2-git-send-email-victor.kamensky@linaro.org>
References: <1410637161-4865-1-git-send-email-victor.kamensky@linaro.org>
 <1410637161-4865-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140913220057.GT12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 12:39:21PM -0700, Victor Kamensky wrote:
> Previous commits that dealt with get_user for 64bit type missed to
> export proper functions, so if get_user macro with particular target/value
> types are used by kernel module modpost would produce 'undefined!' error.
> Solution is to export all required functions.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

Patch looks good on its own, please send to the patch system.

I can either apply it as a follow on patch, or I can merge it into your
original patch.  Which would you prefer?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
