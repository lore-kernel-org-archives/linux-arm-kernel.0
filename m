From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Sep 2011 17:54:59 +0200
Subject: [PATCH] spi: Fix builderror in spi-pl022.c
In-Reply-To: <20110921131052.GG17169@n2100.arm.linux.org.uk>
References: <E1Qvo1q-0000qv-TQ@rmk-PC.arm.linux.org.uk>
	<1314559619-19923-1-git-send-email-peterhuewe@gmx.de>
	<CACRpkdb=Bt2j4iMV5NJHmPG8wDi6__CRD6kn_KOoaQ1R6uwrWQ@mail.gmail.com>
	<CACRpkdbsUMCvBofKjExiB2wCbK9CwpcXr5xmShJ4SHEGAAH4Bw@mail.gmail.com>
	<20110921131052.GG17169@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZio+Xpr6Q+E2Sf5juBDRXUPM5Vjx6GqDg66RDNiFvj3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 3:10 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 20, 2011 at 10:45:41PM +0200, Linus Walleij wrote:

>> > Grant can you please apply this patch? Right now linux-next is
>> > breaking because of this missing patch...
>>
>> Ping on this... ignore if it's been picked already.
>
> Isn't it already fixed? ?I've had this in my tree for quite some time
> (since 5th September) which should also be in linux-next.

It is, just wasn't getting my linux-next right after all the kernelorg
downtime.

Thanks Russell, and sorry for the fuzz.

Yours,
Linus Walleij
