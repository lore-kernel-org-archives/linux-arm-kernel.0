From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 5 May 2013 14:26:55 -0700
Subject: [PATCH 1/1] ARM: at91: rm9200 fix time support
In-Reply-To: <20130505202025.GE24282@game.jcrosoft.org>
References: <20130505202025.GE24282@game.jcrosoft.org>
Message-ID: <20130505212655.GD12954@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 05, 2013 at 10:20:25PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> since commit 838a2ae80a6ab52139fb1bf0a93ea8c5eff94488
> Author: Shawn Guo <shawn.guo@linaro.org>
> Date:   Sat Jan 12 11:50:05 2013 +0000
> 
> ARM: use clockevents_config_and_register() where possible
> 
> The timer is wrongly configured and result in since crash
> so revert it on rm9200 timer
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Greg,
> 
> 	if possible apply it to v3.8 and v3.9 stable
> 
> 	I'll apply it for mainline

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
