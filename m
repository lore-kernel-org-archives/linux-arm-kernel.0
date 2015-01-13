From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Jan 2015 10:25:32 +0100
Subject: [PATCH 6/6] ARM: at91: move at91rm9200_idle() to clk/at91/pmc.c
In-Reply-To: <1421097825-396-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421097825-396-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421097825-396-7-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150113102532.4f75926f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jan 2015 22:23:45 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Move at91rm9200_idle() along with at91sam9_idle() in clk/at91/pmc.c.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> 
> Mike, Boris,
> I guess that one can go through the at91 tree unless you have any objections.

I'm fine with that too.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
