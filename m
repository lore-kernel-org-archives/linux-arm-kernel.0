From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 Mar 2016 13:35:55 -0700
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for
 rk3399
In-Reply-To: <4748955.K1DVHdsoLd@diego> ("Heiko =?utf-8?Q?St=C3=BCbner=22'?=
 =?utf-8?Q?s?= message of "Wed, 16 Mar 2016 12:11:41 +0100")
References: <1458067526-11319-1-git-send-email-david.wu@rock-chips.com>
 <4748955.K1DVHdsoLd@diego>
Message-ID: <7h8u19q6dw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner <heiko@sntech.de> writes:

> Hi David,
>
> Am Mittwoch, 16. M?rz 2016, 02:45:26 schrieb David Wu:
>> This adds the necessary data for handling io voltage domains on the rk3399.
>> As interesting tidbit, the rk3399 contains two separate iodomain areas.
>> One in the regular General Register Files (GRF) and one in PMUGRF in the
>> pmu power domain.
>> 
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>
> looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Rafael, can you queue this directly?  I don't currently have any other
AVS patches in the queue.

Kevin
