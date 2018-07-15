From: johan@kernel.org (Johan Hovold)
Date: Sun, 15 Jul 2018 10:56:28 +0200
Subject: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
In-Reply-To: <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
Message-ID: <20180715085628.GI10204@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 11:56:58PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
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

Reviewed-by: Johan Hovold <johan@kernel.org>
