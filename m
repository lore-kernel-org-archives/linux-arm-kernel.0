From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 30 Jul 2018 17:31:22 +0200
Subject: [PATCH 2/2] pinctrl: stm32: check node status before new gpio
 bank registering
In-Reply-To: <CACRpkdaDy5MGPMxh3GYFHL9VqTv44=t6J=xu_0sdXc4OHFo84g@mail.gmail.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-3-git-send-email-alexandre.torgue@st.com>
 <CACRpkdaDy5MGPMxh3GYFHL9VqTv44=t6J=xu_0sdXc4OHFo84g@mail.gmail.com>
Message-ID: <2f76dbc9-16f1-ddb6-be11-bf0c383b83c6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On 07/29/2018 10:11 PM, Linus Walleij wrote:
> On Mon, Jul 16, 2018 at 2:57 PM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
> 
>> Register a new GPIO bank only if GPIO bank node is enabled. This patch also
>> adds checks on ranges which are defined only if a bank is registered.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> Patch applied.
> 
Thanks

> Alexandre can you check the discussion we've had about using
> GPIOLIB_IRQCHIP for multi-bank GPIOs with several IRQ
> lines as per drivers/gpio/gpio-tegra186.c?
> 
> Is this approach applicable for STM32 so we can pull
> more stuff in under GPIOLIB_IRQCHIP?
> 
Ok. I'm going to check what's possible to do. I let you know soon.

regards
Alex

> Yours,
> Linus Walleij
> 
