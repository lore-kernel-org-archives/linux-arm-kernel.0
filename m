From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 16:16:11 +0000
Subject: [PATCH v3 4/5] ARM: dts: Add STiH407 SoC support
In-Reply-To: <20140310122830.GT14976@lee--X1>
References: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
 <1394203251-25361-5-git-send-email-maxime.coquelin@st.com>
 <20140310122830.GT14976@lee--X1>
Message-ID: <20140310161611.GF13661@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +		CLK_EXT2F_A9: clockgenC0 at 13 {
> 
> s/@/@0x

<snip>

> > +			PIO0: gpio at 09610000 {
> 
> s/@/@0x
> 
> I won't mention this particular point again, but it needs to be
> propagated throughout the patch.

Whoops, I'm actually completely wrong on this point! There is to be
_no_ 0x prefix prior to the address, as per the following commits: 

`git log --author="Lee Jones" --grep="0x" mainline/master -- arch/arm/boot/dts/`

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
