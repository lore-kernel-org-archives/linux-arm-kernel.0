From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Feb 2011 11:35:50 -0800
Subject: [PATCH 1/6] ARM: tegra: add tegra_gpio_table and tegra_gpio_config
In-Reply-To: <AANLkTik9_t0mq07mysO2CcK4ppKAmuPAujownfeWEGL5@mail.gmail.com>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
	<1298354117-19097-2-git-send-email-olof@lixom.net>
	<AANLkTik9_t0mq07mysO2CcK4ppKAmuPAujownfeWEGL5@mail.gmail.com>
Message-ID: <AANLkTimBh2qDx71+P3QCeWJ0sKS1AzYOUohAdSW=AoeS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, Feb 22, 2011 at 11:18 AM, Erik Gilling <konkers@android.com> wrote:
> Can you split the boardfile changes into their own patch? ?Also see
> the below whitespace only change. ?Other than that, looks good.

Ok, done (will push separately, no need to repost just with the split though).

Thanks.


>> ?}
>> -
>> ?postcore_initcall(tegra_gpio_init);
>
> whitespace only change

D'oh, sloppy of me. Fixed.


-Olof
