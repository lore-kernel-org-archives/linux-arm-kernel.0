From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Sep 2011 07:28:04 +0200
Subject: [PATCH] dmaengine: amba-pl08x: make filter check that the channel
	is owned by pl08x
In-Reply-To: <CAHXqBFKVx_AeA2Z_mXVnZg2O4Y2_7C6eKLqgS9-BDr58z4sYVg@mail.gmail.com>
References: <20110831083435.GD26905@n2100.arm.linux.org.uk>
	<CAHXqBFKVx_AeA2Z_mXVnZg2O4Y2_7C6eKLqgS9-BDr58z4sYVg@mail.gmail.com>
Message-ID: <CAKnu2MrcFGqR+CUkgjEm0=T7kj35tdxyQVCeucg8tmcCijdzTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/31 Micha? Miros?aw <mirqus@gmail.com>:
> 2011/8/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> +static struct amba_driver pl08x_amba_driver;
>> +
>
> This will make C++ coders confused a bit. Valid C, though.

We do this kind of forward declarations all over the kernel
if that's what you mean. (I cannot claim to know C++ well
enough to grasp if that's the potential confusion...)

Yours,
Linus Walleij
