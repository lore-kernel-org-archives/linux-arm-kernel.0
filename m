From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Feb 2016 08:38:19 -0600
Subject: [PATCH 4/5] dt-bindings: ata: add compatible string for iProc
 AHCI controller
In-Reply-To: <1455604420-11300-5-git-send-email-anup.patel@broadcom.com>
References: <1455604420-11300-1-git-send-email-anup.patel@broadcom.com>
 <1455604420-11300-5-git-send-email-anup.patel@broadcom.com>
Message-ID: <20160218143819.GA9654@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 12:03:39PM +0530, Anup Patel wrote:
> The Broadcom iProc SoCs have AHCI compliant SATA controller. This
> patch adds common compatible string for AHCI SATA controller on
> iProc SoCs.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
