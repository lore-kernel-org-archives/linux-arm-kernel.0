From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 29 Mar 2018 14:08:58 +0900
Subject: [PATCH] arm64: defconfig: add CONFIG_UNIPHIER_THERMAL and
 CONFIG_SNI_AVE
In-Reply-To: <CAK8P3a3xteNLdGNW=a+jLWmxcEBhBFV8dhL+o0F1AGie=-3hng@mail.gmail.com>
References: <1522153407-21430-1-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK8P3a3xteNLdGNW=a+jLWmxcEBhBFV8dhL+o0F1AGie=-3hng@mail.gmail.com>
Message-ID: <20180329140857.3234.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Sorry for late reply and thanks for applying it.

On Tue, 27 Mar 2018 15:32:34 +0200 <arnd@arndb.de> wrote:

> On Tue, Mar 27, 2018 at 2:23 PM, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> > Enable the thermal monitor driver and the AVE ethernet driver
> > implemented on UniPhier SoCs.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Any reason why this is a built-in driver rather than a loadable module?
> 
> We have a mix of both today for ethernet drivers, but generally I
> would count them as non-essential.

I have no big reason.
I think it's necessary when mounting fs over the network.

Thank you,

---
Best Regards,
Kunihiko Hayashi
