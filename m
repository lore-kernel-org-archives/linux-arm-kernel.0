From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2018 14:16:59 +0200
Subject: [PATCH v2 1/2] pinctrl: uniphier: add LD20 MPEG2-TS I/O pin-mux
 settings
In-Reply-To: <20180427014905.19520-1-suzuki.katsuhiro@socionext.com>
References: <20180427014905.19520-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CACRpkdZUypgGfgWMOy_Vjcu_djRhX1Ue8ReLUNeJ2BQ4LSfF6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 3:49 AM, Katsuhiro Suzuki
<suzuki.katsuhiro@socionext.com> wrote:

> The MPEG2-TS input/output core both accepts serial TS and parallel TS.
>
> The serial TS interface uses following pins:
>   hscin0_s : HS0DOUT[0-3]
>   hscin1_s : HS0DOUT[4-7]
>   hscin2_s : HS1BCLKIN, HS1SYNCIN, HS1VALIN, HS1DIN0
>   hscin3_s : HS1DIN[2-5]
>   hscout0_s: HS0DOUT[0-3]
>   hscout1_s: HS0DOUT[4-7]
>
> And the parallel TS interface uses following pins:
>   hscin0_p : HS0BCLKIN, HS0SYNCIN, HS0VALIN, HS0DIN[0-7]
>   hscin1_p : HS1BCLKIN, HS1SYNCIN, HS1VALIN, HS1DIN[0-7]
>   hscout0_p: HS0BCLKOUT, HS0SYNCOUT, HS0VALOUT, HS0DOUT[0-7]
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Changes in v2:

This v2 version applied with Masahiro's ACK.

Yours,
Linus Walleij
