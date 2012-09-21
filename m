From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 22:00:13 -0700
Subject: [PATCH] ARM: highbank: call highbank_pm_init from .init_machine
In-Reply-To: <1347893712-21819-1-git-send-email-robherring2@gmail.com>
References: <1347893712-21819-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120921050013.GB30535@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 09:55:12AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Being a module_init call, highbank_pm_init will cause problem with
> multi-platform build running on other platforms.  Call it from
> .init_machine instead.
> 
> Reported-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> Arnd, Olof,
> 
> Can you please apply this to the multi-platform branch or I can send an updated
> pull request if you prefer.
> 

Applied.


-Olof
