From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 1 Apr 2010 15:45:03 +0800
Subject: [PATCH 1/4] pxa: add namespace on ssp
In-Reply-To: <y2pf17812d71004010033x5b3e789foa782dd6cd8af63ef@mail.gmail.com>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
	<y2pf17812d71004010033x5b3e789foa782dd6cd8af63ef@mail.gmail.com>
Message-ID: <g2w771cded01004010045n56803dfbge90d3a70a731977d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 1, 2010 at 3:33 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Mar 31, 2010 at 8:46 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From b52a0d2687e82f81d38198cb450b6a39a9e53851 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Wed, 31 Mar 2010 15:08:55 -0400
>> Subject: [PATCH] [ARM] pxa: add namespace on ssp
>>
>> In order to prevent code ambiguous, add namespace on functions in ssp driver.
>>
>
> Haojian,
>
> This is not necessary, provided that those functions are static already.
> Unless this driver is going to support a different SSP, in which case a
> separate driver is needed then.
>
> What's the real motivation behind this?
>

It's the request from Mark. Both ssp_ and pxa_ssp_ prefix exist in
pxa-ssp.c. From the view of naming space, it's not align.

Thanks
Haojian
