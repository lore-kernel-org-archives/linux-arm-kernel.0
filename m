From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 7 Sep 2011 22:02:04 -0700
Subject: [PATCH v2] gpio: rewrite U300 GPIO to use gpiolib
In-Reply-To: <20110907180207.GC9937@ponder.secretlab.ca>
References: <1315383085-26352-1-git-send-email-linus.walleij@stericsson.com>
	<20110907180207.GC9937@ponder.secretlab.ca>
Message-ID: <CACxGe6vp7FS3YqOB2QUg+k-qC5t8sGFDjwJb1GSqxuV+BFWE-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 11:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Sep 07, 2011 at 10:11:25AM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This rewrites the U300 GPIO so as to use gpiolib and
>> struct gpio_chip instead of just generic GPIO, hiding
>> all the platform specifics and passing in GPIO chip
>> variant as platform data at runtime instead of the
>> compiletime kludges.
>>
>> As a result <mach/gpio.h> is now empty for U300 and
>> using just defaults.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>
>> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Reported-by: Ben Hutchings <ben@decadent.org.uk>
>> Signed-off-nu: Linus Walleij <linus.walleij@linaro.org>
> ? ? ? ? ? ? ^^
> Your keyboard needs to be shifted 1cm to the right. :-)
>
> I'll pick it up, but there are some things that I've commented on
> below that needs to be addressed in follow up patches.

Hmmm, it doesn't apply against mainline.  Do you want to take it
through your tree?

g.
