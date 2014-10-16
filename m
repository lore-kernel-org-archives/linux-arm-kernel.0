From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Oct 2014 17:51:23 +0100
Subject: [PATCH] arm64/efi: set PE/COFF file alignment to 512 bytes
In-Reply-To: <1412960335-22905-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1412960335-22905-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141016165123.GD5252@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 05:58:55PM +0100, Ard Biesheuvel wrote:
> Change our PE/COFF header to use the minimum file alignment of
> 512 bytes (0x200), as mandated by the PE/COFF spec v8.3
> 
> Also update the linker script so that the Image file itself is also a
> round multiple of FileAlignment.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Another one from the PE/COFF rabbit hole. I will follow up next week and repost
> as a coherent series, once I have collected all the feedback.

If Matt is taking more patches in this series, here's my ack:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
