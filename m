From: info@lategoodbye.de (Stefan Wahren)
Date: Mon, 21 Dec 2015 19:08:56 +0100
Subject: [PATCH 4/4] ARM: bcm2835: Switch to using the new clock driver
 support.
In-Reply-To: <03BE10FE-D743-4CD3-8825-112D0F6B2D43@martin.sperl.org>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-5-git-send-email-eric@anholt.net>
 <5677E7BF.3020404@martin.sperl.org> <5677F3C8.5000600@lategoodbye.de>
 <03BE10FE-D743-4CD3-8825-112D0F6B2D43@martin.sperl.org>
Message-ID: <56784038.402@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[fix Michael's address and add Remi]

Am 21.12.2015 um 16:17 schrieb Martin Sperl:
>
> I started looking and found that drivers/clk/bcm/clk-bcm2835.c
> does not include the PWM clock either.

yes but please look at Remi's patch series first:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-December/002672.html

Regards
Stefan
