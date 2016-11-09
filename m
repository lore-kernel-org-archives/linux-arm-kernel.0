From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:26:15 -0600
Subject: [PATCH v2 1/2] mmc: sdhci-iproc: Add brcm,sdhci-iproc compat
 string in bindings document
In-Reply-To: <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
 <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
Message-ID: <20161109182615.22m3wpkv3bi4rcto@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 09:37:56AM -0700, Scott Branden wrote:
> Adds brcm,sdhci-iproc compat string to DT bindings document for
> the iProc SDHCI driver.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
