From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 Apr 2018 12:11:50 +0900
Subject: [PATCH v2 1/2] pinctrl: uniphier: add LD20 MPEG2-TS I/O pin-mux
 settings
In-Reply-To: <20180427014905.19520-1-suzuki.katsuhiro@socionext.com>
References: <20180427014905.19520-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNARSB3q6aheYNjzC4BAP6C+SZE+arDbqbpaK8F31iR82aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-27 10:49 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
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
>
> ---
>
> Changes in v2:
>
>   - Fix indent
>   - Sort alphabetically
>   - Fix wrong grouping
>     - Fix hsc'out'0_ci -> hsc'in'0_ci of hscin0 group
>     - Fix hscin'0'_s -> hscin'1'_s of hscin1 group


This version looks good to me.

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
