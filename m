From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 31 Mar 2016 21:35:20 +0100
Subject: [PATCH] efi/arm64: don't apply MEMBLOCK_NOMAP to UEFI memory map
 mapping
In-Reply-To: <1459323983-9120-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459323983-9120-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160331203520.GB2736@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar, at 09:46:23AM, Ard Biesheuvel wrote:
> Hi Matt,
> 
> Could we queue this as a fix for v4.6 with a cc:stable for v4.5, please?
> (assuming no objections from any of the cc'ees)

Yep, I've picked this up. I'll go out to tip tomorrow.
