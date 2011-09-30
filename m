From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Sep 2011 19:20:56 +0200
Subject: [PATCH] drivers: create a pin control subsystem v8
In-Reply-To: <CACxGe6v19pZ0i-+ksYZbG2ZvGT30UkXEHTzpZMBTB4RNUV5bnA@mail.gmail.com>
References: <1317211419-18472-1-git-send-email-linus.walleij@stericsson.com>
	<20110930020754.GK12606@ponder.secretlab.ca>
	<CACRpkdYyyqB6=5M8reqgwpMxXJz5ttXWyOav6K58dQ0CrxwCNA@mail.gmail.com>
	<CACxGe6v19pZ0i-+ksYZbG2ZvGT30UkXEHTzpZMBTB4RNUV5bnA@mail.gmail.com>
Message-ID: <CACRpkdZxxLdJQEkG--5Uf8DX+-00yOecb_NMpf0QSpP8u5hR4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 7:07 PM, Grant Likely <grant.likely@secretlab.ca> wrote:

> [Me]
>> That is not the reason it's there actually, what we have
>> discussed on the mailing list is getting sysfs entries for the same
>> reason gpiolib registers a class: handle pin control from userspace,
>>(...)
>
> Sure, but you don't need the bus yet. ?It can be added when it is
> actually needed. ?I'm not convinced that the sysfs approach is
> actually the right interface here (I'm certainly not a fan of the gpio
> sysfs i/f), and I'd rather not be putting in unneeded stuff until the
> userspace i/f is hammered out.

OK I buy that, I will post a v9 without bus...

Thanks!
Linus Walleij
