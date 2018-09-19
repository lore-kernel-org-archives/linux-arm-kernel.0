From: james.morse@arm.com (James Morse)
Date: Wed, 19 Sep 2018 01:46:41 +0100
Subject: [PATCH v4] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1536067493-31454-1-git-send-email-wufan@codeaurora.org>
References: <1536067493-31454-1-git-send-email-wufan@codeaurora.org>
Message-ID: <33dde632-3ab9-cab3-38cc-cc841a9e88e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On 09/04/2018 02:24 PM, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
