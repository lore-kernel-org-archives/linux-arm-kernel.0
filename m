From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 11:21:32 +0200
Subject: [PATCH 1/5] gpiolib: devres: Introduce the function
 devm_request_gpio_array
In-Reply-To: <53BD2509.6070803@codethink.co.uk>
References: <cover.1404665589.git.himangi774@gmail.com>
 <1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com>
 <53BD2509.6070803@codethink.co.uk>
Message-ID: <CACRpkdZWfYN14aki-UqvWp1K0exVj-mMK92q431QueSVvjZFuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 1:18 PM, Rob Jones <rob.jones@codethink.co.uk> wrote:

> Please note that I submitted a patch on 02/07/14 to create this
> function which was acked by Linus Walleij on 05/07/14.
>
> Great minds think alike, and all that.

My mind certainly isn't any great :-(

My left hand seems to be unaware of what the right hand is doing.

Did I ACK that for merging through some other tree then?

And I guess if Himangi want to submit these ASoC patches, they
will have to go through the same tree as those patches in that case?

And would you consider implementing a gpiod version...?

> However, I think that the version I submitted better replicates the
> original (non devm) functionality, see below.
>
> I didn't, however, add it to the documentation. +1 on that.

Can you include that oneliner in your patch then to reduce
problems?

Yours,
Linus Walleij
