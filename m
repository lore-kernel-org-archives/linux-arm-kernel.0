From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 14 Nov 2018 17:12:13 +0100
Subject: [PATCH V3 1/7] net: lorawan: Add macro and definition for LoRaWAN
In-Reply-To: <20181114160126.4445-2-starnight@g.ncu.edu.tw>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-2-starnight@g.ncu.edu.tw>
Message-ID: <aaee242e-a287-9db6-4374-73f2ee9fc9d2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.11.18 um 17:01 schrieb Jian-Hong Pan:
> This patch adds the macro and definition for the implementation of
> LoRaWAN protocol.
> 
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
> V2:
> - Modify the commit message

Note that both v2 and v3 don't seem to be based on the latest lora-next
branch, as your constants are already queued and used there.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
