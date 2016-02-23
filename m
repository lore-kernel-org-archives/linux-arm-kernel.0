From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Feb 2016 14:54:37 -0600
Subject: [PATCH v3 2/2] iio: dac: vf610_dac: Add IIO DAC driver for
 Vybrid SoC
In-Reply-To: <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
References: <cover.1456121233.git.maitysanchayan@gmail.com>
 <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
Message-ID: <20160223205437.GA27366@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 11:48:37AM +0530, Sanchayan Maity wrote:
> Add driver support for DAC peripheral on Vybrid SoC.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/dac/Kconfig                            |  10 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/vf610_dac.c                        | 298 +++++++++++++++++++++
>  5 files changed, 338 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
>  create mode 100644 drivers/iio/dac/vf610_dac.c
