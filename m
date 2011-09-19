From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 19 Sep 2011 11:56:11 +0100
Subject: [PATCH] pata-generic/of: Make probing via device tree
	non-powerpc-specific
In-Reply-To: <1316427795.3014.13.camel@hornet.cambridge.arm.com>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
	<20110916214313.GB16381@n2100.arm.linux.org.uk>
	<CA+wbFdc0SicHLN6=JQz-rRXqKovhr7=acUQi3esUU_qcXgCaAw@mail.gmail.com>
	<1316427795.3014.13.camel@hornet.cambridge.arm.com>
Message-ID: <CA+wbFddgygAyGedeCUjs-zfCRcaZsN2COFPJ7W4MR4Hk1tOGUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 11:23 AM, Pawel Moll <pawel.moll@arm.com> wrote:
>> > This may not be the correct way to support the CF slot on Versatile
>> > Express - it depends whether the CF slot on VE supports just CF
>> > memory cards or whether it can take any CF card.
>> >
>> > If the latter, then what may be inserted could be a CF network card,
>> > and that means it's probably wrong to tell the kernel that what's
>> > there is a PATA interface.
>>
>> Interesting point. ?I don't know whether we've tried plugging anything
>> else in...
>>
>> Pawel, can you comment?
>
> VE officially supports CF memory cards only (Arnd already referenced the
> spec). So in this case CF == PATA.

OK, Il'l stick with this for now.

Cheers
---Dave
