From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Aug 2014 20:07:22 +0800
Subject: [PATCH] ARM: dts: imx6sx: fix the pad setting for uart CTS_B
In-Reply-To: <1408349484-840-1-git-send-email-b38611@freescale.com>
References: <1408349484-840-1-git-send-email-b38611@freescale.com>
Message-ID: <20140819120721.GC2404@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 04:11:24PM +0800, Fugang Duan wrote:
> The current pinfunc define all uart CTS_B IO port for DCE uart 'CTS_B'
> IP port. Since uart IP port 'CTS_B' is output, and it don't need to
> set 'SELECT_INPUT' bit.
> 
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Applied, thanks.
