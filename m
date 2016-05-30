From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 30 May 2016 22:12:12 +0100
Subject: [PATCH] arm64/efi: remove spurious WARN_ON for !4K kernels
In-Reply-To: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
References: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160530211212.GG2984@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 May, at 04:11:56PM, Mark Rutland wrote:
> 
> No further restriction on alignment is provided in the UEFI
> specification, neither generically nor in a rule specific to AArch64.
 
This surprises me. I could have sworn the intention was to add this
restriction to the spec when the strict permissions were being
discussed in the UEFI working groups.

Am I reinventing history?

As an aside, Mark, Jeremy, which machines did you see this warning
triggered on? Preproduction/development boards or also in the wild?
