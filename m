From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 14:23:57 +0200
Subject: [PATCH 4/9 v2] crypto: ux500/cryp - Prepare clock before enabling
 it
In-Reply-To: <20130419122226.GB3432@gmail.com>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-5-git-send-email-lee.jones@linaro.org>
 <20130419122226.GB3432@gmail.com>
Message-ID: <201304191423.57261.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Lee Jones wrote:
> Slight change of plan for v2.
> 
> Now we're doing a seperate clk_prepare(), as the clk_enable() in the
> previous patch turned out to be called inside a spin_lock().
> 
> Arnd, can you confirm your Ack please?
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
