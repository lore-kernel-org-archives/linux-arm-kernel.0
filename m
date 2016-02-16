From: robh@kernel.org (Rob Herring)
Date: Tue, 16 Feb 2016 11:28:07 -0600
Subject: [PATCH v6sub1 02/11] of/fdt: factor out assignment of
 initrd_start/initrd_end
In-Reply-To: <1455627162-31600-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455627162-31600-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAL_JsqJEZ+O-VCAYyAbZD4LygRYKyfM4Xh+qMpx5a8-o-OX_Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 6:52 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Since architectures may not yet have their linear mapping up and running
> when the initrd address is discovered from the DT, factor out the
> assignment of initrd_start and initrd_end, so that an architecture can
> override it and use the translation it needs.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/of/fdt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
