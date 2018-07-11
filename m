From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Jul 2018 14:46:47 -0700
Subject: [PATCH] ARM: defconfig: Set CONFIG_LOCALVERSION in multi
 v4t/v5/v7 defconfigs
In-Reply-To: <20180711142649.4556-1-geert+renesas@glider.be>
References: <20180711142649.4556-1-geert+renesas@glider.be>
Message-ID: <CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 11, 2018 at 7:26 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This allows to derive the kernel flavor from the kernel version at
> runtime.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I prefer not to have this go in -- this is extremely likely to creep
into derivative configs and as such it would have no value (you can't
be sure it's still the same config).

/proc/config.gz is the way to keep track of exactly what config you're
running anyway, right?

-Olof
