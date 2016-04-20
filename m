From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Apr 2016 20:18:04 +0200
Subject: [PATCH] ARM: pxa: Remove CLK_IS_ROOT
In-Reply-To: <1461116269-2555-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Tue, 19 Apr 2016 18:37:49 -0700")
References: <1461116269-2555-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <87wpnsrvoj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Queued to pxa/for-next, thanks !

Cheers.

-- 
Robert
