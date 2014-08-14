From: msalter@redhat.com (Mark Salter)
Date: Thu, 14 Aug 2014 09:55:16 -0400
Subject: [PATCH 4/7] arm64/efi: uefi_init error handling fix
In-Reply-To: <1408007731-15081-4-git-send-email-dyoung@redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
 <1408007731-15081-4-git-send-email-dyoung@redhat.com>
Message-ID: <1408024516.599.134.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-08-14 at 17:15 +0800, Dave Young wrote:
> There's one early memmap leak in uefi_init error path, fix it and slightly tune
> the error handling code.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/arm64/kernel/efi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Mark Salter <msalter@redhat.com>
