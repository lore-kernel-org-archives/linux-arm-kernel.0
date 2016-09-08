From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Sep 2016 21:24:51 -0700
Subject: [PATCH] arm-cci: pmu: Fix typo in event name
In-Reply-To: <1473089273-19311-1-git-send-email-suzuki.poulose@arm.com>
References: <1473089273-19311-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160908042451.GC20110@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 04:27:53PM +0100, Suzuki K Poulose wrote:
> For one of the CCI events exposed under sysfs, "snoop" was typo'd as
> "snopp". Correct this such that users see the expected event name when
> enumerating events via sysfs.
> 
> Cc: arm at kernel.org
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied, thanks.


-Olof
