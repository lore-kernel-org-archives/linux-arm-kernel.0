From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 11:25:15 -0500
Subject: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
In-Reply-To: <20170802093429.12572-5-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
 <20170802093429.12572-5-jonas.gorski@gmail.com>
Message-ID: <20170810162515.qkmhcnsaoh4wjrzs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 11:34:25AM +0200, Jonas Gorski wrote:
> Codify using a named clock for the refclk of the uart. This makes it
> easier if we might need to add a gating clock (like present on the
> BCM6345).
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
>  drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
