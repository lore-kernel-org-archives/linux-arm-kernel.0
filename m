From: rob.jones@codethink.co.uk (Rob Jones)
Date: Thu, 10 Jul 2014 12:01:28 +0100
Subject: [PATCH 1/5] gpiolib: devres: Introduce the function
 devm_request_gpio_array
In-Reply-To: <CACRpkdZWfYN14aki-UqvWp1K0exVj-mMK92q431QueSVvjZFuA@mail.gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>	<1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com>	<53BD2509.6070803@codethink.co.uk>
 <CACRpkdZWfYN14aki-UqvWp1K0exVj-mMK92q431QueSVvjZFuA@mail.gmail.com>
Message-ID: <53BE7288.6060503@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/14 10:21, Linus Walleij wrote:
> On Wed, Jul 9, 2014 at 1:18 PM, Rob Jones <rob.jones@codethink.co.uk> wrote:
>
>> Please note that I submitted a patch on 02/07/14 to create this
>> function which was acked by Linus Walleij on 05/07/14.
>>
>> Great minds think alike, and all that.
>
> My mind certainly isn't any great :-(
>

I doubt that :-)

> My left hand seems to be unaware of what the right hand is doing.
>
> Did I ACK that for merging through some other tree then?
>

You did: https://lkml.org/lkml/2014/7/4/715

> And I guess if Himangi want to submit these ASoC patches, they
> will have to go through the same tree as those patches in that case?
>

I don't know enough to comment.

> And would you consider implementing a gpiod version...?
>

I will certainly consider it. I'm in the middle of something else right
now but I should be available in a day or two and I'll have a look.

>> However, I think that the version I submitted better replicates the
>> original (non devm) functionality, see below.
>>
>> I didn't, however, add it to the documentation. +1 on that.
>
> Can you include that oneliner in your patch then to reduce
> problems?
>

Certainly, with acknowledgement to Himangi Saraogi. Should I resubmit
the patch series with amendment or should I put it in as a separate
patch? Sorry for the noobie question but I *am* new to the kernel
lists.

> Yours,
> Linus Walleij
>
>

-- 
Rob Jones
Codethink Ltd
mailto:rob.jones at codethink.co.uk
tel:+44 161 236 5575
