From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 03 Dec 2012 18:20:27 +0000
Subject: [PATCH 1/3] ARM: nommu: allow unaligned accesses on ARMv6+
 processors
In-Reply-To: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
References: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
Message-ID: <50BCED6B.8010206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/12 17:56, Will Deacon wrote:
> Commit 8428e84d ("ARM: 7150/1: Allow kernel unaligned accesses on ARMv6+
> processors") unconditionally clears SCTLR.A for ARMv6+ processors, since
> newer toolchains assume that unaligned memory accesses will not fault
> for these cores.
>
> This patch adds the corresponding change for nommu kernel builds.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

For the series:
Tested-by: Jonathan Austin <jonathan.austin@arm.com>

(Tested on Cortex-R Series models)

Jonny
