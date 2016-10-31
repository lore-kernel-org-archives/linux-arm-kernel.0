From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 23:27:51 -0500
Subject: [PATCH 1/2] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477503355-2600-2-git-send-email-bgolaszewski@baylibre.com>
References: <1477503355-2600-1-git-send-email-bgolaszewski@baylibre.com>
 <1477503355-2600-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20161031042751.r6gzbgzejalmxrhn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 07:35:54PM +0200, Bartosz Golaszewski wrote:
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
