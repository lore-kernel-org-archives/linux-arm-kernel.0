From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 10:01:30 +0200
Subject: [PATCH v2] gpio: rewrite U300 GPIO to use gpiolib
In-Reply-To: <CACxGe6vp7FS3YqOB2QUg+k-qC5t8sGFDjwJb1GSqxuV+BFWE-w@mail.gmail.com>
References: <1315383085-26352-1-git-send-email-linus.walleij@stericsson.com>
	<20110907180207.GC9937@ponder.secretlab.ca>
	<CACxGe6vp7FS3YqOB2QUg+k-qC5t8sGFDjwJb1GSqxuV+BFWE-w@mail.gmail.com>
Message-ID: <CACRpkdb-0Rc14ist47OeVtRxgj8tU3eDhNujc4RJFZjgG75mbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 7:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Sep 7, 2011 at 11:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Wed, Sep 07, 2011 at 10:11:25AM +0200, Linus Walleij wrote:
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> This rewrites the U300 GPIO so as to use gpiolib and
>>> struct gpio_chip instead of just generic GPIO, hiding
>>> all the platform specifics and passing in GPIO chip
>>> variant as platform data at runtime instead of the
>>> compiletime kludges.
>>>
>>> As a result <mach/gpio.h> is now empty for U300 and
>>> using just defaults.
>>>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>
>>> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
>>> Reported-by: Ben Hutchings <ben@decadent.org.uk>
>>> Signed-off-nu: Linus Walleij <linus.walleij@linaro.org>
>> ? ? ? ? ? ? ^^
>> Your keyboard needs to be shifted 1cm to the right. :-)
>>
>> I'll pick it up, but there are some things that I've commented on
>> below that needs to be addressed in follow up patches.

I know this...
Cut me some slack will ya.
Atleast it makes things better, not worse.

> Hmmm, it doesn't apply against mainline. ?Do you want to take it
> through your tree?

I will feed it to Russells GPIO cleanup branch, where the
prerequisites are.

Thanks!
Linus Walleij
