From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 15:47:18 -0600
Subject: [PATCH 16/19] mmc: mmci: add DT bindings for STM32 sdmmc
In-Reply-To: <1528809280-31116-17-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-17-git-send-email-ludovic.Barre@st.com>
Message-ID: <20180625214718.GA28647@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 03:14:37PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> STM32 sdmmc variant has support to:
> -Indicate signal directions (only one property
> for d0dir, d123dir, cmd_dir)
> -Select command and data phase relation.
> -Select "clock in" from an external driver.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  2 files changed, 15 insertions(+)
