From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Jul 2013 15:55:37 +0800
Subject: [PATCH 1/2] ARM i.MX53: mba53: Fix PWM backlight DT node
In-Reply-To: <1373553468-6564-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20130712075535.GE25501@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 04:37:47PM +0200, Laurent Pinchart wrote:
> The i.MX53 PWM controller uses two cells to describe the PWM specifier.
> Remove the extra unused values from the backlight DT node pwms property.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied, thanks.
