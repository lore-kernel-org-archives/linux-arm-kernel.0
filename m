From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 22 Aug 2017 19:01:52 +0800
Subject: [PATCH v5 1/9] ASoC: rockchip: Remove obsolete dmic-delay
In-Reply-To: <20170822103241.wjiycavsro7abknj@sirena.org.uk>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-2-jeffy.chen@rock-chips.com>
 <20170822103241.wjiycavsro7abknj@sirena.org.uk>
Message-ID: <599C0F20.7080807@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/22/2017 06:32 PM, Mark Brown wrote:
> On Tue, Aug 22, 2017 at 03:57:20PM +0800, Jeffy Chen wrote:
>> This property is no longer used.
>
> I would still rather keep the existing property documented (the binding
> does need to be fixed) than remove it.  It's better practice and it's
> not costing a huge amount.
>

sorry, i should explain more in the commit msg...

just to clarify, this property is replaced by 
"realtek,dmic-init-delay-ms" in rt5514 driver:

a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

which does exactly the same thing as the old one: perform a delay after 
set clk...

i can do that if you still insist to keep it, since it's harmless :)
