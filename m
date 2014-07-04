From: msalter@redhat.com (Mark Salter)
Date: Fri, 04 Jul 2014 12:52:36 -0400
Subject: [PATCH v3] efi/arm64: handle missing virtual mapping for UEFI
 System Table
In-Reply-To: <1404487509-26084-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1404487509-26084-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1404492756.19665.57.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-04 at 17:25 +0200, Ard Biesheuvel wrote:
> If we cannot resolve the virtual address of the UEFI System Table, its physical
> offset must be missing from the virtual memory map, and there is really no point
> in proceeding with installing the virtual memory map and the runtime services
> dispatch table. So back out gracefully.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Acked-by: Mark Salter <msalter@redhat.com>
