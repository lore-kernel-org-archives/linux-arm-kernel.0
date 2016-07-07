From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 7 Jul 2016 09:46:50 +0200
Subject: [PATCH] clocksource: cadence_ttc: fix a return value in case of
 error
In-Reply-To: <1467783323-16632-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1467783323-16632-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <20160707074650.GA13755@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 07:35:23AM +0200, Christophe JAILLET wrote:
> IS_ERR and PTR_ERR should use the same variable, clk_ce in this case.
> 
> Fixes: 4de1eb07c47f (Convert init function to return error)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks.

  -- Daniel
