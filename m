From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Jan 2013 11:15:45 -0700
Subject: [RFC PATCH 1/5] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to system reset controller
In-Reply-To: <1357751839-19680-2-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
 <1357751839-19680-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <50EDB3D1.5010900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 10:17 AM, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../devicetree/bindings/reset/fsl,imx-src.txt      |   45 ++++++++++++++++++++

I proposed something very similar a while back; it may be useful to look
at the previous discussion there:

http://www.spinics.net/lists/arm-kernel/msg202451.html

Unfortunately, I haven't had time to follow up on the proposal.
