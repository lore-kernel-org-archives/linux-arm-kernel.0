From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Jan 2012 08:19:37 +0100
Subject: snowball does not compile on linux-next
In-Reply-To: <20120102152553.GA9771@async.com.br>
References: <4F0199CF.2070806@linaro.org>
 <CACRpkdbn6H_s8oC3VdqH2CoCZcPkc+hYccLE1UQJZnqB5eSf3Q@mail.gmail.com>
 <20120102152553.GA9771@async.com.br>
Message-ID: <CACRpkdZfaOA0suxO8Gp7mw-VGPFju2dCJwDocO_K7Dx4-2z0Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2012 at 4:25 PM, Christian Robottom Reis <kiko@linaro.org> wrote:
> On Mon, Jan 02, 2012 at 01:59:10PM +0100, Linus Walleij wrote:
>> On Mon, Jan 2, 2012 at 12:49 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>
>> > the kernel does not compile when
>> > CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK is set.
>
> Should this be in our default configs, or one of our tested configs, so
> we can catch this in a CI loop?

It should be in the defconfig already, the problem showed up
for Daniel exactly because it was configured in.

Yours,
Linus Walleij
