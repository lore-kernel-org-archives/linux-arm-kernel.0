From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 19 Sep 2017 09:22:08 +0000
Subject: linux-4.14-rc1/drivers/clk/clk-stm32h7.c: 2 * possible typo ?
In-Reply-To: <12ce6ec0-d351-4ffe-a5a0-cdc09f6aee39@st.com>
References: <12ce6ec0-d351-4ffe-a5a0-cdc09f6aee39@st.com>
Message-ID: <73cadb19-a75e-4938-265f-890cc5a4d3b4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

I confirm it's typo issue. I 'm ready to send a fix for that.

Many Thank's

Gabriel

> Hello there,
>
> 1.
>
> linux-4.14-rc1/drivers/clk/clk-stm32h7.c:387]: (style) Same expression
> on both sides of '&&'.
>
> Source code is
>
>   ??? if (gcfg->mux && gcfg->mux) {
>
> 2.
>
> [linux-4.14-rc1/drivers/clk/clk-stm32h7.c:413]: (style) Same expression
> on both sides of '&&'.
>
> Duplicate.
>
> Regards
>
> David Binderman
