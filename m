From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 19 Apr 2011 18:25:35 +0800
Subject: [PATCH] pxa/hx4700: bq24022 regulator needs to be enabled
In-Reply-To: <20110419084032.GA30743@rainbow>
References: <E1QAkBF-0003bF-A0@outmx04.plus.net>
	<20110419084032.GA30743@rainbow>
Message-ID: <BANLkTikLNbYdTKHiu+gn7wpAS86KPZWN1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 4:40 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> On 14:39 Fri 15 Apr ? ? , Paul Parsons wrote:
>> Add REGULATOR_CHANGE_STATUS flag to hx4700 bq24022 regulator. Without this flag the bq24022 cannot be enabled and the battery will not charge.
>>
> Ah, so that's why my hx4700 doesn't charges under linux! I noticed
> that some time ago, but never found the time to investigate this.
> Thanks for finding this out. Will test.
>
> BTW, this should probably go through Eric Miao's PXA tree, so adding him
> to CC list.
>

Applied to 'fix'.
