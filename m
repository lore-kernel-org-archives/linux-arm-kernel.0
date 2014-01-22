From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 11:09:39 +0000
Subject: [PATCH v4 1/5] arm: break part of __soft_restart out into
 separate function
In-Reply-To: <1389445524-30623-2-git-send-email-leif.lindholm@linaro.org>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
 <1389445524-30623-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140122110939.GE1621@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 01:05:20PM +0000, Leif Lindholm wrote:
> Certain operations can be considered mandatory for any piece of code
> preparing to switch off the MMU. Break this out into separate function
> dmap_prepare().

idmap_prepare. dmap_prepare sounds like something *completely* different!

With that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
