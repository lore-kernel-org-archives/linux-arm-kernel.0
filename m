From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 24 Apr 2012 21:59:43 +0800
Subject: [PATCH] ARM pxa pcm027: use ioremap to access CPLD
In-Reply-To: <20120424081714.GS3852@pengutronix.de>
References: <1334223908-14690-1-git-send-email-s.hauer@pengutronix.de>
 <CAMPhdO-+AVHmo40tzhADLysnenbD=72hgx5U6sv09HuA9haZ2g@mail.gmail.com>
 <20120424081714.GS3852@pengutronix.de>
Message-ID: <CAMPhdO_Doc9doDP1zEKbyiizRs4WibBkKZOoygCgaXY9mA5+9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 4:17 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Apr 20, 2012 at 04:58:01PM +0800, Eric Miao wrote:
>> On Thu, Apr 12, 2012 at 5:45 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> > The pcm990 baseboard for the pcm027 module used to setup a static
>> > mapping for accessing the CPLD. It became illegal to call iotable_init
>> > that late. The pcm027 support is broken since then. This patch
>> > switches the cpld support to ioremap and removes all references to
>> > previous static mappings.
>> >
>> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> Looks good to me.
>>
>> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
> Thanks Eric. Who will take this patch?

Haojian, please help on this.
