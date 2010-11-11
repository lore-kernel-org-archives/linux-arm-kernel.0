From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Wed, 10 Nov 2010 19:37:15 -0600
Subject: [PATCH 6/6] omap:clocks44x-add dummy clock for mailbox
In-Reply-To: <alpine.DEB.2.00.1011101626570.28301@utopia.booyaka.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
	<1289393121-7911-7-git-send-email-h-kanigeri2@ti.com>
	<alpine.DEB.2.00.1011101626570.28301@utopia.booyaka.com>
Message-ID: <AANLkTimD-dzC_UhJTK7=BZ27cMWRqy49LwOuVJxGz4hx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Wed, Nov 10, 2010 at 5:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Hari
>
> On Wed, 10 Nov 2010, Hari Kanigeri wrote:
>
>> In omap4, there is no explicit configuration register to enable mailbox clocks.
>> Defining dummy clock for mailbox clock module to keep the mailbox driver
>> backward compatible with previous omaps.
>
> If you split this off from the rest of your series, I'll queue it for .38.
>

Thanks. I will send this patch separately.

Best regards,
Hari
