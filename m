From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:24:30 -0600
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20161109182430.yh6uqeu2ufzkctww@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 03:45:34PM +0100, Bartosz Golaszewski wrote:
> Create a new driver for the da8xx DDR2/mDDR controller and implement
> support for writing to the Peripheral Bus Burst Priority Register.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/memory/Kconfig                             |   8 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/da8xx-ddrctl.c                      | 175 +++++++++++++++++++++
>  4 files changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>  create mode 100644 drivers/memory/da8xx-ddrctl.c
