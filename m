From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 22 Feb 2016 14:03:12 +0000
Subject: [PATCH 0/6] Support for systems without AArch32 state
In-Reply-To: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <56CB1520.8020907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 11:32, Suzuki K Poulose wrote:
> This series add checks to make sure that the AArch32 state is
> supported before we process the 32bit ID registers. Also
> checks the same for COMPAT binary execution.

Yuri,

Could you please give this series a spin on your hardware ?
I don't have access to system where I can test this.

Thanks
Suzuki
