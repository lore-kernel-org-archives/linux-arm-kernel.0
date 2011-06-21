From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 21 Jun 2011 18:14:15 +0800
Subject: [PATCH 2/2] ARM: pxa168: correct nand pmu setting
In-Reply-To: <BANLkTimKsHSODub79sc9MbNqVbtFqYzHDw@mail.gmail.com>
References: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
	<1308650059-27226-2-git-send-email-leiwen@marvell.com>
	<BANLkTimKsHSODub79sc9MbNqVbtFqYzHDw@mail.gmail.com>
Message-ID: <BANLkTinLq82kj5JdWDFA93=86sUjVZJR2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Jun 21, 2011 at 6:09 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Jun 21, 2011 at 5:54 PM, Lei Wen <leiwen@marvell.com> wrote:
>> The original pair of <0x01db, 208000000> is invalid.
>> Correct to the valid value.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>
> Lei,
>
> As pxa168 boards are available outside now, please describe more on this
> change. Due to silicon revision, erratum, or due to the original code was
> too long ago that it is no long valid.
>
> Note - check the pxa168 boards file, make sure the change will not affect
> them.

That value 0x01db only means 78Mhz, and from all doc I could refer to
the 0x01db never reach
to 208MHZ...

Do you means I should keep the 0x1db register value?

Thanks,
Lei
