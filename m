From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 6 Aug 2012 13:37:04 +0200
Subject: [PATCH] ARM: ux500: resurrect I2C platform data
In-Reply-To: <20120806095144.GA16996@gmail.com>
References: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
 <20120806095144.GA16996@gmail.com>
Message-ID: <501FAC60.1080600@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2012 11:51 AM, Lee Jones wrote:
> On Mon, Aug 06, 2012 at 10:52:26AM +0200, Linus Walleij wrote:
>> Commit:
>> 98582d9562b4bea6b0eb6e2bfafcd3fab3b60ccb
>> "ARM: ux500: Remove unused i2c platform_data initialisation code"
>>
>> Deleted platform data intialization code that was used,
>> not unused as indicated in the commit. The boot log (without
>> devicetree) now looks like this:
> The aforementioned commit was part of a patch-set. One of its affiliates
> moved this code into the Nomadik I2C driver; however, it was contested
> because Device Tree support was also added and the maintainer thought
> the properties introduced could be consolidated with other I2C driver's
> DT properties. I don't think anyone has taken up the consolidation work
> and for that reason it hasn't gone in.

Too bad it had to turn into a regression though :-P

> I think moving this stuff into the driver is the right thing to do.
> Instead, I'll split out the configuration and DT enablement from the
> patch and resubmit.
>
> Sound good to you?

Either way works with me, but the patch sent out need to be
rebased and sent to Wolfram. Either he applies that to the I2C
tree or I apply this to the ux500 tree. So it's for Wolfram to decide.

Yours,
Linus Walleij
