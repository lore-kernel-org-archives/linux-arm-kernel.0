From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Sep 2012 11:38:11 -0600
Subject: [PATCH] pinctrl/nomadik : add MC1_a_2 pin MC1 function group list
In-Reply-To: <1347265874-3342-1-git-send-email-linus.walleij@stericsson.com>
References: <1347265874-3342-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <504E2583.4070602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2012 02:31 AM, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@stericsson.com>
> 
> Another possible pin configuration for the MC1 pin group.

I have no objection to this, but I wonder if these will keep trickling
in. Is it a good idea to audit the whole driver and add everything
that's missing in one go?
