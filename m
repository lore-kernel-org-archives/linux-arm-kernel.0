From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 19:48:21 -0300
Subject: [GIT PULL 6/6] i.MX defconfig updates for 4.17
In-Reply-To: <CAK8P3a2mUiAQRUZSvTwX=9ukEY6LWPTFqj=9WwWf2=OO3L-q7g@mail.gmail.com>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-6-git-send-email-shawnguo@kernel.org>
 <CAK8P3a2mUiAQRUZSvTwX=9ukEY6LWPTFqj=9WwWf2=OO3L-q7g@mail.gmail.com>
Message-ID: <CAOMZO5B+ofiSZFbNLczCLsBAcaNMe9PRS1S2N9nkFx87msHSbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Mar 15, 2018 at 12:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I didn't pull this one, it seems to remove some config symbols without
> an explanation what happened to them:
>
> -CONFIG_FHANDLE=y
> -# CONFIG_ARM_THUMB is not set
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
> -# CONFIG_DEVKMEM is not set
> -CONFIG_NVMEM=y
> -CONFIG_LOCKUP_DETECTOR=y
> -CONFIG_TIMER_STATS=y
>
> Can you have another look? I want to be sure that we don't
> accidentally turn off something important when the respective
> Kconfig symbol got renamed or it gained a dependency that
> is no longer met.

I can take a look.

Which specific patch are you talking about?
