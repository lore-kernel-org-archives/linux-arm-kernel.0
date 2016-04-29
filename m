From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 29 Apr 2016 15:03:51 +0100
Subject: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
In-Reply-To: <572344D8.6060401@st.com>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana> <5722107C.3000600@st.com>
 <20160428145720.GA1541@katana> <572344D8.6060401@st.com>
Message-ID: <20160429140351.GA1459@griffinp-mac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, 29 Apr 2016, Maxime Coquelin wrote:

> 
> 
> On 04/28/2016 04:57 PM, Wolfram Sang wrote:
> >>The trick is to switch to SPI mode, 9 bits words and write a 0,
> >>so that 9 clock pulses are generated.
> >Heh. As long as it works :) But as you said, it really needs a comment.
> >
> :)
> I didn't faced the problem myself, but it looks good with an oscilloscope,
> and a customer reported it to work.
> 
> Peter, will you resend with adding the explanations I provided as comment?
>
Yes I'll send a v2 with your comment added.

Peter
