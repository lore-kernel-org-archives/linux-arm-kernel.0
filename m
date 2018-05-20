From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 20:36:07 +0800
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: limit usbh1 to full-speed
In-Reply-To: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
References: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
Message-ID: <20180520123606.GU26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 11:45:02AM +0300, Nikita Yushchenko wrote:
> On RDU1, imx51 usbh1 interface is either not used, or used via external
> block that breaks USB2 signalling.
> 
> To keep things working if high-speed device gets connected to that
> block, use ChipIdea feature to limit port to full speed.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Applied, thanks.
