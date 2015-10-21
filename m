From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Oct 2015 09:44:38 +0100
Subject: [PATCHv4 02/24] arm64: Delay ELF HWCAP initialisation until all
 CPUs are up
In-Reply-To: <1445261101-22344-3-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
 <1445261101-22344-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151021084434.GD4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:24:39PM +0100, Suzuki K. Poulose wrote:
> Delay the ELF HWCAP initialisation untill all the (enabled) CPUs are

nit: untill

No need to fix this unless you respin the series for some other
reason.

[...]

Cheers
---Dave
