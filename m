From: marcel@holtmann.org (Marcel Holtmann)
Date: Sat, 14 Jul 2018 18:27:33 +0200
Subject: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
In-Reply-To: <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
Message-ID: <ED7E5A98-81DC-41B9-9B9A-3EF4EBBED854@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

> In order to open up the required power gate before any operation can be
> effectively performed over the serial bus between CPU and serdev, it's
> clearly essential to add common attach functions for PM domains to serdev
> at the probe phase.
> 
> Similarly, the relevant dettach function for the PM domains should be
> properly and reversely added at the remove phase.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial at vger.kernel.org
> ---
> drivers/tty/serdev/core.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)

can we take this through the serial subsystem? Or should I just take it when the driver is ready to be included?

Regards

Marcel
