From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 24 Feb 2016 10:03:02 -0800
Subject: [PATCH v3] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <56CDB912.6000300@arm.com>
References: <1456272534-21692-1-git-send-email-ddaney.cavm@gmail.com>
 <20160224134016.GH28310@arm.com> <56CDB912.6000300@arm.com>
Message-ID: <56CDF056.8020408@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2016 06:07 AM, Marc Zyngier wrote:
> On 24/02/16 13:40, Will Deacon wrote:
>
> [...]
>
>> (and Catalin, if you pick this up, watch out for the conflicts in
>> cpufeature.h)
>
> Yup, that one is about to become a minefield (ARM64_HAS_NO_HW_PREFETCH,
> ARM64_HAS_UAO, ARM64_ALT_PAN_NOT_UAO and ARM64_HAS_VIRT_HOST_EXTN are
> already happily clashing into -next). But hey, the more the merrier! ;-)
>

Would you like me to rebase it to for-next/core ?


David.

> Thanks,
>
> 	M.
>
