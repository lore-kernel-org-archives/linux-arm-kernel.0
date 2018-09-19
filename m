From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Sep 2018 11:07:20 +0100
Subject: [PATCH 1/3] arm64/cpufeatures: Introduce ESR_ELx_SYS64_ISS_RT()
In-Reply-To: <1537328050-29176-2-git-send-email-anshuman.khandual@arm.com>
References: <1537328050-29176-1-git-send-email-anshuman.khandual@arm.com>
 <1537328050-29176-2-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1f732ef3-12a7-6c27-adb9-0fe5ab93a33d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2018 04:34 AM, Anshuman Khandual wrote:
> Extracting target register from ESR.ISS encoding has already been required
> at multiple instances. Just make it a macro definition and replace all the
> existing use cases.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
