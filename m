From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jul 2014 17:20:27 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140716110927.GK7978@ulmo>
References: <20140714183624.GV6800@sirena.org.uk> <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
 <53C4DF0D.8010208@metafoo.de>
 <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <20140716110927.GK7978@ulmo>
Message-ID: <CACRpkdZr=i+s5DzmR3n+FKC3DzvqfZCKM=HaWSX5WiwcCENBUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 1:09 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jul 16, 2014 at 09:50:02AM +0100, Rob Jones wrote:

>> In light of this, should I hold off starting on devm_gpiod_get_array()
>> as discussed on here last week?
>
> I'll let Alex or Linus answer this, since I wasn't involved in the
> devm_gpiod_get_array() discussions.

I'm gonna shut up in this thread as Alex is doing such an excellent
job at hashing out the details of gpiod*, and he understands it way
better than me.

Yours,
Linus Walleij
