From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 21 Oct 2014 09:55:37 -0700
Subject: [PATCH] spi/atmel: improve the system suspend/resume functions
 implementation
In-Reply-To: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com> (Wenyou
 Yang's message of "Tue, 21 Oct 2014 11:43:34 +0800")
References: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <7hlho9cqgm.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wenyou Yang <wenyou.yang@atmel.com> writes:

> To make it cleaner, the system suspend/resume directly call
> the runtime suspend/resume functions
> and remove the wapper of CONFIG_PM_RUNTIME, CONFIG_PM_SLEEP.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
