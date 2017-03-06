From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Mon, 06 Mar 2017 13:55:19 +0900
Subject: [PATCH v4 1/5] arm64: dts: exynos: Add the burst and esc clock
 frequency properties to DSI node
In-Reply-To: <20170306044912.b7syhwilwxygpjlj@gangnam.samsung>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044233epcas1p20b5e6c764a7752290e5ed25cc13a69af@epcas1p2.samsung.com>
 <1488775343-6236-2-git-send-email-hoegeun.kwon@samsung.com>
 <20170306044912.b7syhwilwxygpjlj@gangnam.samsung>
Message-ID: <da4e17f1-809d-6013-b3ea-d4470e2427f4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2017 01:49 PM, Andi Shyti wrote:
> Hi Hoegeun,
>
> On Mon, Mar 06, 2017 at 01:42:19PM +0900, Hoegeun Kwon wrote:
>> The OF graph is not needed because the panel is a child of dsi. Add
>> the burst and esc clock frequency properties to the parent (DSI node).
>>
>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> you forgot to put me in Cc and add my
>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Sorry Andi, I mistake... :(
Thanks for all your review.

Best Regards,
Hoegeun

>
> Andi
>
>
