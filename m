From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 18 Jul 2016 16:24:21 -0500
Subject: [PATCH 03/10] of: irq: make of_msi_configure accessible from
 modules
In-Reply-To: <1468867177-15007-4-git-send-email-okaya@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-4-git-send-email-okaya@codeaurora.org>
Message-ID: <CAL_Jsq+zLb0RcEdykDZXZpkgjjrDWa+-Bd0LTth3kB4H5X9pOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 1:39 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The of_msi_configure routine is only accessible by the built-in
> kernel drivers. Export this function so that modules can use it
> too.
>
> This function is useful for configuring MSI on child device tree
> nodes on hierarchical objects.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
