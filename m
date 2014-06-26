From: msalter@redhat.com (Mark Salter)
Date: Thu, 26 Jun 2014 09:58:07 -0400
Subject: [PATCH v2 0/2] efi: preserve NEON registers on UEFI services calls
In-Reply-To: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1403791087.755.120.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-06-26 at 12:09 +0200, Ard Biesheuvel wrote:
> The current UEFI implementation for arm64 fails to preserve/restore the contents
> of the NEON register file,

Does the current implementation actually use NEON registers?
I know there are some at least, which build with -mgeneral-regs-only
to keep gcc from using NEON registers.

Not that that means we don't need this. Just curious.
