From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 14:27:53 +0800
Subject: [PATCH] ARM i.MX6q: unmap memory mapped at
 imx6q_opp_check_speed_grading()
In-Reply-To: <1421171213-19159-1-git-send-email-bigeasy@linutronix.de>
References: <1421171213-19159-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <20150120062752.GR2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 06:46:53PM +0100, Sebastian Andrzej Siewior wrote:
> imx6q_opp_check_speed_grading() remaps memory to the base variable and
> never unmaps it. I can't see how this can be of any use later so here I
> unmap it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied, thanks. 
