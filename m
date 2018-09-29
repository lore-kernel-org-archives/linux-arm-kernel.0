From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Sat, 29 Sep 2018 10:37:18 +0100
Subject: [PATCH v2 1/7] arm64: move arm uprobes code to be reused by arm64
In-Reply-To: <1537963925-25313-2-git-send-email-m.slodczyk2@partner.samsung.com>
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce@eucas1p2.samsung.com>
 <1537963925-25313-2-git-send-email-m.slodczyk2@partner.samsung.com>
Message-ID: <0d10bc6d-5fb1-fac3-3d68-352b0cfd4af2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2018 01:11 PM, Maciej Slodczyk wrote:
> Move ARM32 uprobes code from arch/arm/probes/ to a more common location -
> lib/probes/arm/. This code will be used by ARM64 code when uprobing 32-bit
> applications.

The patch looks OK to me, with the following nit:

The subject tag looks incorrect. Since this patch moves the ARM
code around and has nothing to do with arm64 (yet). So, the subject
could be :

ARM: move uprobes code to be reused by arm64

which could allow the concerned arm people to check this patch.

Suzuki
