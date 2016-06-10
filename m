From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 10 Jun 2016 16:31:28 +0100
Subject: [PATCH 4/6] arm64: errata: Calling enable functions for CPU
 errata too
In-Reply-To: <1462812590-4494-5-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
 <1462812590-4494-5-git-send-email-andre.przywara@arm.com>
Message-ID: <575ADD50.2060109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/16 17:49, Andre Przywara wrote:
> Currently we call the (optional) enable function for CPU _features_
> only. As CPU _errata_ descriptions share the same data structure and
> having an enable function is useful for errata as well (for instance
> to set bits in SCTLR), lets call it when enumerating erratas too.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

These changes look good to me.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Suzuki
