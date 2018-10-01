From: m.slodczyk2@partner.samsung.com (Maciej Slodczyk)
Date: Mon, 1 Oct 2018 15:12:51 +0200
Subject: [PATCH v2 1/7] arm64: move arm uprobes code to be reused by arm64
In-Reply-To: <0d10bc6d-5fb1-fac3-3d68-352b0cfd4af2@arm.com>
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce@eucas1p2.samsung.com>
 <1537963925-25313-2-git-send-email-m.slodczyk2@partner.samsung.com>
 <0d10bc6d-5fb1-fac3-3d68-352b0cfd4af2@arm.com>
Message-ID: <20181001131254eucas1p2ae0390483d52f18e37b9550a59da52aa~ZfkMUwYnn1170611706eucas1p2k@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29.09.2018 11:37, Suzuki K Poulose wrote:
> following nit:
> 
> The subject tag looks incorrect. Since this patch moves the ARM
> code around and has nothing to do with arm64 (yet). So, the subject
> could be :
> 
> ARM: move uprobes code to be reused by arm64
> 
> which could allow the concerned arm people to check this patch.

Hi,

Thank you for the review. I'll adjust subject tags in v3.

Thank you,
Maciej
