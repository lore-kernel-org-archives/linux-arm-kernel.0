From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 16:45:05 +0800
Subject: [PATCH 1/2] ARM: dts: imx6qdl-hummingboard: fix USBOTG-ID pin
In-Reply-To: <535f327ebffa93ee780381e6c9f9f39b7c6d1a26.1519027005.git.baruch@tkos.co.il>
References: <535f327ebffa93ee780381e6c9f9f39b7c6d1a26.1519027005.git.baruch@tkos.co.il>
Message-ID: <20180224084504.GL3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 09:56:44AM +0200, Baruch Siach wrote:
> From: Jon Nettleton <jon@solid-run.com>
> 
> Fix the USBOTG-ID pin to the correct definition.  The top
> USB port stays in device-mode without this change.
> 
> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied both, thanks.
