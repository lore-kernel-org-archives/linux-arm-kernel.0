From: stefan.roese@mailbox.org (Stefan Roese)
Date: Mon, 15 Aug 2016 07:31:13 +0200
Subject: [PATCH v2] clocksource/drivers/time-armada-370-xp: Fix the clock
 reference
In-Reply-To: <1470834867-25932-1-git-send-email-gregory.clement@free-electrons.com>
References: <1470834867-25932-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <99dfbccf-ca49-7fc9-f163-0bebfa4d6ee7@mailbox.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.08.2016 15:14, Gregory CLEMENT wrote:
> While converting the init function to return an error, the wrong clock
> was get. This lead to wrong clock rate and slow down the kernel. For
> example, before the patch a typical boot was around 15s after it was 1
> minute slower.
>
> Fixes: 12549e27c63c ("clocksource/drivers/time-armada-370-xp: Convert init function to return error")
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Tested-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
