From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Mar 2016 09:31:15 +0100
Subject: [PATCH 00/50] pinctrl: Add and use devm_ apis for
 pinctrl_{register, unregister}
In-Reply-To: <56E031CA.9010204@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdZjv2KZ0AtC9oBytmSdS+=T+kC8PoJVt-RawE8Np8p40w@mail.gmail.com>
 <56D307CC.2050202@nvidia.com> <56E031CA.9010204@nvidia.com>
Message-ID: <CACRpkdYQL0HUWuz882RRsSu5hLoS5VcVvpm1LeL1aeJkE_Y0tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 3:23 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

>> Pushed the change at:
>> Branch "devm_pinctrl_register" of
>> https://github.com/ldewangan/linux-upstream.git.
>>
>> Base repo is
>> for-next of
>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
>>
>>
>> If required, I can send the V2 version of list with acks.
>
> Let me know if I need to send full series (V2 with collected ack) again or
> fine to pull it from above location.

Please collect the ACKs on your branch and ask me to pull it after v4.6-rc1.
No need to resend the patches.

Unfortunately it arrived too late for the merge window, but hey: we got the
devm gpiochip in for v4.6.

Yours,
Linus Walleij
