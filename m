From: geoff@infradead.org (Geoff Levand)
Date: Thu, 20 Oct 2016 09:37:03 -0700
Subject: [PATCH v2] arm64: Add support for additional relocations in the
 kexec purgatory code
In-Reply-To: <1476960211-25594-1-git-send-email-catalin.marinas@arm.com>
References: <1476960211-25594-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <2792b205-dfdd-1362-9cf4-d886472a9357@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2016 03:43 AM, Catalin Marinas wrote:
> When compiling the kexec-tools with gcc6, the following additional
> reolcations are generated in the purgatory.ro file:
> 
> R_AARCH64_ADR_PREL_PG_HI21
> R_AARCH64_ADD_ABS_LO12_NC
> R_AARCH64_LDST64_ABS_LO12_NC

Looks good.  Simon, please apply.

Reviewed-by: Geoff Levand <geoff@infradead.org>
