From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 5 Nov 2009 11:46:58 +0800
Subject: [PATCH] [ARM] pxa/pxa3xx.c: register U2D clock
In-Reply-To: <f870da180911041402o14d9f2ccwd3c16c66d0346b75@mail.gmail.com>
References: <1257336880-16011-1-git-send-email-grinberg@compulab.co.il>
	<f17812d70911040647l35739ed3hf749112d43b79354@mail.gmail.com>
	<f870da180911041402o14d9f2ccwd3c16c66d0346b75@mail.gmail.com>
Message-ID: <f17812d70911041946q85aeb9bi414d3fa42243c0c0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 6:02 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:
>
>
> On Wed, Nov 4, 2009 at 4:47 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>
>> On Wed, Nov 4, 2009 at 8:14 PM, Igor Grinberg <grinberg@compulab.co.il>
>> wrote:
>> >
>> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>
>> ISTR U2D is present on pxa310 _only_, if that's the case, might
>> better put the clock into pxa300.c. Please help double check.
>>
>
> On pxa310 the U2D differs in capabilities from pxa300/320. But they all use
> the same clock :)
>

True. Applied in 'devel', thanks.
