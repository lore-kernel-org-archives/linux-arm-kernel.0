From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Feb 2016 14:07:14 +0000
Subject: [PATCH v3] arm64: Add workaround for Cavium erratum 27456
In-Reply-To: <20160224134016.GH28310@arm.com>
References: <1456272534-21692-1-git-send-email-ddaney.cavm@gmail.com>
 <20160224134016.GH28310@arm.com>
Message-ID: <56CDB912.6000300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/16 13:40, Will Deacon wrote:

[...]

> (and Catalin, if you pick this up, watch out for the conflicts in
> cpufeature.h)

Yup, that one is about to become a minefield (ARM64_HAS_NO_HW_PREFETCH,
ARM64_HAS_UAO, ARM64_ALT_PAN_NOT_UAO and ARM64_HAS_VIRT_HOST_EXTN are
already happily clashing into -next). But hey, the more the merrier! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
