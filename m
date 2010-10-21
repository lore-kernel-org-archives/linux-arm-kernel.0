From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 21 Oct 2010 10:49:27 +0900
Subject: [PATCH 5/5] ARM: SAMSUNG: Add to enable/disable clock on S3C PL330
In-Reply-To: <AANLkTimbHbO77POKuu=3XAO6Cq7UaAjJ291hwQqKTcNW@mail.gmail.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
	<1287622713-1657-6-git-send-email-kgene.kim@samsung.com>
	<AANLkTi=ZTBuPBDL4MZ7MPn3Ha_cNhyShosyzn8q6QF3N@mail.gmail.com>
	<AANLkTimbHbO77POKuu=3XAO6Cq7UaAjJ291hwQqKTcNW@mail.gmail.com>
Message-ID: <AANLkTinaDckVpJhadBcnhccdougyCG-FbXe23dh=_ep8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 10:45 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Thu, Oct 21, 2010 at 10:32 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>> On Thu, Oct 21, 2010 at 9:58 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>> From: Seungwhan Youn <sw.youn@samsung.com>
>>>
>>> This patch adds to enable/disable DMA operation clock on S3C-PL330
>>> DMA controller driver.
>>
>> The title and description seems to clock gating but actual code is
>> just enable at probe and disable at remove.
>>
>> Can you make it REAL clock gating, enable clock only when using?
>
> Of course we can. But that will need some intrusive changes.
> Later, we'll implement that desirable feature.
> For now, many SoCs don't detect PL330 since the clocks are gated
> by default and we don't enable them in driver. So, this is just to get
> latest SoCs' PL330 working.

I see even though I don't know "later" is how much

and include the s5pc210 code also at this patchset.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
