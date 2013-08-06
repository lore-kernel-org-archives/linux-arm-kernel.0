From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Aug 2013 07:13:09 +0900
Subject: [PATCH 2/2] media: s5p-mfc: remove DT hacks and simplify
 initialization code
In-Reply-To: <030d01ce928e$de27e190$9a77a4b0$%debski@samsung.com>
References: <1375705610-12724-1-git-send-email-m.szyprowski@samsung.com>
 <1375705610-12724-3-git-send-email-m.szyprowski@samsung.com>
 <030d01ce928e$de27e190$9a77a4b0$%debski@samsung.com>
Message-ID: <520174F5.6060508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/13 19:22, Kamil Debski wrote:
> Hi Kukjin,
>
> This patch looks good.
>
> Best wishes,
> Kamil Debski
>
>> From: Marek Szyprowski [mailto:m.szyprowski at samsung.com]
>> Sent: Monday, August 05, 2013 2:27 PM
>>
>> This patch removes custom initialization of reserved memory regions
>> from s5p-mfc driver. Memory initialization can be now handled by
>> generic code.
>>
>> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
>
> Acked-by: Kamil Debski<k.debski@samsung.com>
>
Kamil, thanks for your ack.

Applied.
- Kukjin
