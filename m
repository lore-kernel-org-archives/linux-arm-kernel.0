From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Jan 2014 19:29:46 +0100
Subject: [PATCH 01/17] ARM: spear: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201401021929.46581.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 December 2013, Daniel Lezcano wrote:
> This flag is a NOOP and scheduled to be removed
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for sending this series. I think the patches are duplicates of stuff that
Michael Opdenacker has sent before (actually multiple times). I have no problem
applying either version into arm-soc, but I think it would be better to attribute
them to Michael, since he came first. Can you two please coordinate and send a
single pull request for the arm-soc related patches that haven't made it into
linux-next yet?

	Arnd
