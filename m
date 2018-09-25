From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 10:27:34 -0500
Subject: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
In-Reply-To: <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-27-git-send-email-ludovic.Barre@st.com>
Message-ID: <20180925152734.GA28148@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:46:20AM +0200, Ludovic Barre wrote:
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
> change v3:
> -remove space at end of "st,use-ckin "
> 
>  Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++

I acked v1. Please add acks when posting new versions.

>  drivers/mmc/host/mmci.c                        | 6 ++++++
>  drivers/mmc/host/mmci.h                        | 1 +
>  3 files changed, 16 insertions(+)
