From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 16:04:56 +0800
Subject: [PATCH] pxa/hx4700: Remove pcmcia platform_device structure
In-Reply-To: <CAN1soZwmLmTgnR+vqQtUyqsivhbuJRdd6YmDgLb5Vi+e5CVAzQ@mail.gmail.com>
References: <1331305076.23513.YahooMailClassic@web29009.mail.ird.yahoo.com>
 <CAN1soZwmLmTgnR+vqQtUyqsivhbuJRdd6YmDgLb5Vi+e5CVAzQ@mail.gmail.com>
Message-ID: <CAN1soZyxEQNMVerxnjaLHiQQgW3MQKg1cqKxCqVg7av9oqf4ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 4:03 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Fri, Mar 9, 2012 at 10:57 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
>> The existing pcmcia platform_device structure is not used and is not needed by
>> the pending hx4700 PCMCIA/CF support. So let's remove it.
>>
>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
>
> Excuse me to response late. Will hx4700 support PCMCIA driver?

Oh. I missed one patch. Please ignore my comments.
