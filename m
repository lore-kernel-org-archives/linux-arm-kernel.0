From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 09:17:16 -0500
Subject: [PATCH v2 5/6] clk: stm32f469: Add QSPI clock
In-Reply-To: <1476436699-21879-6-git-send-email-gabriel.fernandez@st.com>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
 <1476436699-21879-6-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161018141716.cdxywazk6kfg7z64@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 11:18:18AM +0200, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the QSPI clock for stm32f469 discovery board.
> The gate mapping is a little bit different from stm32f429 soc.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32-rcc.txt     |   4 +-
>  drivers/clk/clk-stm32f4.c                          | 173 ++++++++++++++++++---
>  2 files changed, 158 insertions(+), 19 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
