From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:56:49 -0400
Subject: [PATCH 03/16] Rename memory allocation/free functions
In-Reply-To: <1376090777-20090-4-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-4-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402209.27484.14.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> Rename them to be more similar, as low_free() could be used to free
> memory allocated by both high_alloc() and low_alloc().
> high_alloc() -> efi_high_alloc()
> low_alloc()  -> efi_low_alloc()
> low_free()   -> efi_free()
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
