From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 20 Apr 2018 12:07:44 +0200
Subject: [PATCH v1 1/5] ARM: configs: multi_v7: Add I2C support
In-Reply-To: <1524215874-15093-2-git-send-email-pierre-yves.mordret@st.com>
References: <1524215874-15093-1-git-send-email-pierre-yves.mordret@st.com>
 <1524215874-15093-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <CAMuHMdWwmsOm_LjjhYBFseFa1HaWFCbGEGf+XbZxSSf3JC=vPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

On Fri, Apr 20, 2018 at 11:17 AM, Pierre-Yves MORDRET
<pierre-yves.mordret@st.com> wrote:
> This patch adds I2C F7 support to multi_v7_defconfig
>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks for your patch!

I think the subject should be "ARM: multi_v7_defconfig: Add STM32F7
I2C support",
as generic I2C support is already enabled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
