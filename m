From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Nov 2015 18:13:39 +0000
Subject: [PATCH 0/5] arm64: cpufeature: Fixes for 4.4-rc1
In-Reply-To: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151126181339.GS3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 05:03:53PM +0000, Suzuki K. Poulose wrote:
> This series contains fixes for two issues.
> 
>  Patches 1 - 3:	Handling of unsigned feature values, issu reported
> 		by AKASHI Takahiro.
> 
>  Patches 4 - 5:	Adds a check to make sure all the secondary CPUs have
> 		compatible ASIDBits to prevent system crashes.
> 
> Suzuki K. Poulose (5):
>   arm64: cpufeature: Add helpers for extracting unsigned values
>   arm64: cpufeature: Track unsigned fields
>   arm64: debug: Treat the BRPs/WRPs as unsigned

I merged the first three patches, there are still discussions on the
last two. Thanks.

-- 
Catalin
