From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Sep 2014 09:39:32 +0100
Subject: [PATCH v2 1/4] arm64, thunder: Add Kconfig option for Cavium
 Thunder SoC Family
In-Reply-To: <1409903205-2762-2-git-send-email-rric@kernel.org>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <1409903205-2762-2-git-send-email-rric@kernel.org>
Message-ID: <20140905083932.GD13515@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 08:46:42AM +0100, Robert Richter wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> Increase maximum numbers of cpus to 32. This relates to current
> maximal possible cpu number. Increasing this to 64 cpus will be a
> separate patch not part of this enablement patches.

Just out of interest, does raising the current maximum limit actually break
any existing code? If not, then doing this as two patches doesn't seem worth
it.

Will
