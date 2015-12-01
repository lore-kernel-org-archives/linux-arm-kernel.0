From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 11:00:31 +0100
Subject: [PATCH 3/3] ARM: dts: enable pinctrl for Broadcom NSP
In-Reply-To: <5654FBE4.5010802@gmail.com>
References: <1448042309-46445-1-git-send-email-yrdreddy@broadcom.com>
 <5654FBE4.5010802@gmail.com>
Message-ID: <CACRpkdZCBbrfHq+DiWcfe6i_2FPUXyMQwbsQu5_zAKYa=fJugg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 1:08 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 20/11/15 09:58, Yendapally Reddy Dhananjaya Reddy wrote:
>> This enables the pinctrl support for Broadcom NSP SoC
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
>
> Looks like a sane pinctrl node here, unless there are objections, I
> would like to go ahead and apply this for v4.5, thanks!

I'm waiting for an indication from the other BCM pinctrl
maintainers to tell whether this SoC is unique enough to deserve
its own driver.

Yours,
Linus Walleij
