From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Feb 2016 08:51:00 -0600
Subject: [PATCH v1 2/2] iio: dac: vf610_dac: Add IIO DAC driver for
 Vybrid SoC
In-Reply-To: <5a699d45c89d239f3e49fa83d16a9b467016e219.1454939346.git.maitysanchayan@gmail.com>
References: <cover.1454939346.git.maitysanchayan@gmail.com>
 <5a699d45c89d239f3e49fa83d16a9b467016e219.1454939346.git.maitysanchayan@gmail.com>
Message-ID: <20160212145100.GA12514@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 10:56:06AM +0530, Sanchayan Maity wrote:
> Add driver support for DAC peripheral on Vybrid SoC.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/dac/Kconfig                            |   8 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/vf610_dac.c                        | 302 +++++++++++++++++++++
>  4 files changed, 331 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
>  create mode 100644 drivers/iio/dac/vf610_dac.c
