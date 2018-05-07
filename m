From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 15:51:51 -0500
Subject: [PATCH] iio: adc: stm32-dfsdm: Add support for stm32mp1
In-Reply-To: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
References: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180507205151.GA25321@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 03:05:23PM +0200, Fabrice Gasnier wrote:
> Add support for DFSDM (Digital Filter For Sigma Delta Modulators)
> to STM32MP1. This variant is close to STM32H7 DFSDM, it implements
> 6 filter instances. Registers map is also increased.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt         |  7 +++++--
>  drivers/iio/adc/stm32-dfsdm-core.c                  | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
