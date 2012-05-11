From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 May 2012 09:54:25 +0200
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
In-Reply-To: <201205101328.36524.arnd@arndb.de>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
 <4FAB7D29.9000107@free-electrons.com> <4FAB815A.8040109@atmel.com>
 <201205101328.36524.arnd@arndb.de>
Message-ID: <4FACC5B1.80601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

Since everyone seems to have put his Acked-By (Nicolas, Arnd and you),
are you ok to merge it in your tree ?

You still had some minor comments, do you you want me to post a new
patchset to the mailing list, or a public git branch would be enough ?

Thanks,
Maxime

Le 10/05/2012 15:28, Arnd Bergmann a ?crit :
> On Thursday 10 May 2012, Nicolas Ferre wrote:
>> So I would really like to keep the non-DT probing. This will give the
>> ability for users to experiment IIO/ADC with whichever kernel revision,
>> whichever AT91 SoC they like.
>>
>> Arnd, we will have to agree on a way to push this work into mainline,
>> but please consider keeping the non-DT part for this driver.
> 
> Ok. If the non-DT part is important to you, I suggest you merge it
> all through the IIO tree, to avoid dependency problems with the
> platform data header file.
> 
> Please add my Acked-by for the arch/arm patches.
> 
> 	Arnd


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
