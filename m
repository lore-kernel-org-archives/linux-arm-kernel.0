From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 10 Jan 2016 16:05:51 +0100 (CET)
Subject: [PATCH V2 0/2] serial: bcm2835: add bcm2835 auxiliar uart driver
In-Reply-To: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1057226922.507844.cb24b396-67be-4b7b-9938-7cb30ef4fe05.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 9. Januar 2016 um 14:07 geschrieben:
>
>
> From: Martin Sperl <kernel@martin.sperl.org>
>
> This patch series adds the bcm2835aux uart driver, which is created
> as a wrapper arround the 8250 driver (based on recommendations by
> Stephen Warren)
>
> The device tree patch itself is not included yet because this
> patch requires the clk-bcm2835aux driver, which is right now only
> in clk-next, but should become available with 4.5.

it doesn't make sense without the device tree patch. IMHO it's okay as long as
you point out the dependency and set the node status to disable.

Best regards
Stefan
