From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 4 Dec 2014 15:15:49 +0800
Subject: [PATCH v2 0/4] clk: mediatek: Add common clock support for
 Mediatek MT8135.
In-Reply-To: <1417675942-10502-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1417675942-10502-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1417677349.31427.26.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2014-12-04 at 14:52 +0800, James Liao wrote:
> This patchset contains the initial common clock support for Mediatek SoCs.
> Mediatek SoC's clock architecture comprises of various PLLs, dividers,
> muxes and clock gates.
> 
> This patchset also contains a basic clock support for Mediatek MT8135.
> 
> This driver is based on 3.18-rc1 + MT8135 basic support.
> 

Changein v2:
- Re-ordered patchset. Fold include/dt-bindings and DT document in 1st
patch.
