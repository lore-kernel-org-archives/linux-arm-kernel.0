From: ben@simtec.co.uk (Ben Dooks)
Date: Fri, 02 Jul 2010 14:34:27 +0100
Subject: [PATCH 0/3] ARM: S5PV210: Add MIPI-DSI support.
In-Reply-To: <4C29AF72.6090200@samsung.com>
References: <4C29AF72.6090200@samsung.com>
Message-ID: <4C2DEAE3.9030903@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/10 09:31, InKi Dae wrote:
> Hello all,
> 
> This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).
> 
> LCD Panel can use following interfaces,
> - RGB or CPU Interface.
> - RGB or CPU Interface based on MIPI-DSI.
> 
> In case of small size lcd panel, it was ok only rgb or cpu interface not
> using mipi controller.
> But big size panel(more then 480x800) needs MIPI-DSI Interface or other
> hardwares like LVDS

Hmm, I must have imagined connecting up an 1024x768 panel to an RGB
interface then.
