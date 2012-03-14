From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 16:22:34 +0800
Subject: [PATCH] pxa/hx4700: Remove pcmcia platform_device structure
In-Reply-To: <CA+gwMce5x8XddOoKKNhYVfowstUtfeTNegJYA41av6EBLvS7sg@mail.gmail.com>
References: <1331305076.23513.YahooMailClassic@web29009.mail.ird.yahoo.com>
 <CA+gwMce5x8XddOoKKNhYVfowstUtfeTNegJYA41av6EBLvS7sg@mail.gmail.com>
Message-ID: <CAN1soZwG_EyVPjfQoAz-b8Z56pjPVbQJY7k3fDqoe7+k2kw=+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 1:35 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> On Fri, Mar 9, 2012 at 3:57 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
>> The existing pcmcia platform_device structure is not used and is not needed by
>> the pending hx4700 PCMCIA/CF support. So let's remove it.
>>
>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
>
> Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
>
Applied
