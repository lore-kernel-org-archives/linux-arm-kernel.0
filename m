From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 08:05:56 -0500
Subject: [PATCH] of: reserved_mem: restore old behavior when no region is
 defined
In-Reply-To: <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
References: <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
 <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAL_JsqKNpx09UFkGB0n9W0GkAv8OVUdRN8cYriau83SdD6xnuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2016 at 1:51 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Change return value back to -ENODEV when no region is defined for given
> device. This restores old behavior of this function, as some drivers rely
> on such error code.
>
> Reported-by: Liviu Dudau <liviu.dudau@arm.com>
> Fixes: 59ce4039727ef40 ("of: reserved_mem: add support for using more than
>        one region for given device")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
