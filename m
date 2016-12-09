From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Dec 2016 15:02:12 -0600
Subject: [PATCH 1/3] nvmem: imx-ocotp: Add support for i.MX6UL
In-Reply-To: <1480689949-17957-1-git-send-email-d.schultz@phytec.de>
References: <1480689949-17957-1-git-send-email-d.schultz@phytec.de>
Message-ID: <20161209210212.jb3uuxtfdkmdi2sd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 03:45:47PM +0100, Daniel Schultz wrote:
> This patch adds OCOTP support for the i.MX6UL SoC.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 5 +++--
>  drivers/nvmem/imx-ocotp.c                             | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
