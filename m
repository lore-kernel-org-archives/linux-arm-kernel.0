From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 24 May 2013 16:05:28 +0200
Subject: [PATCH] ARM: at91/dt: add pinctrl definition for at91 tc blocks
In-Reply-To: <1369389956-30466-1-git-send-email-b.brezillon@overkiz.com>
References: <1369389956-30466-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130524140528.GE24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:05 Fri 24 May     , Boris BREZILLON wrote:
> Hello,
> 
> This patch adds pinctrl configs for at91 Timer Conter blocks.
> These pin configs will be referenced by "atmel,tcb-pwm" devices to
> setup pins as PWM output.

you need to rebase on

a cleanup I did preset on our git tag at91-3.11-cleanup

As we announce Mandaotory for 3.11

as I introduce Macro fro DT

Best Regards,
J.
