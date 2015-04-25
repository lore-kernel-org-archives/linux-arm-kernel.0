From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 25 Apr 2015 09:54:52 +0800
Subject: [PATCH 0/3] ARM: sun9i: Add support for PRCM on Allwinner A80
 SoC
In-Reply-To: <20150330215034.GT23664@lukather>
References: <1425349320-2754-1-git-send-email-wens@csie.org>
 <20150308173225.GK5085@lukather> <201503100902208865029@allwinnertech.com>
 <20150310201800.GA5085@lukather> <2015033017191699787718@allwinnertech.com>
 <20150330215034.GT23664@lukather>
Message-ID: <CAGb2v66YPXDbSC3ZfTKx1bwYVakCrBENSAYVGTZhwk_f0Ve68g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

(Dropped a few people from CC.)

On Tue, Mar 31, 2015 at 5:50 AM, maxime.ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Kevin,
>
> On Mon, Mar 30, 2015 at 05:19:17PM +0800, kevin at allwinnertech.com wrote:
>> Hi, Maxime,
>>
>> We have add the PRCM module description to the A80 document.
>> You can download it from the github: https://github.com/allwinner-zh/documents
>
> Awesome, thanks a lot.
>
> We'll look into it.

I looked at the new PRCM description, which is very detailed.
I have some questions though:

1. There is a "PLL_AUDIO control". Is this a new PLL? Or just another
set of mapped
   registers for PLL_AUDIO in CCU? I assume it is the latter.

2. What is the source of "24 MHz" in the main CCU? The external 24 MHz
oscillator
   (HOSC) or the mux after HOSC and CLK16M_RC? (ref: page 331, the
PRCM block diagram)

Please help clarify them. Thank you.


Regards
ChenYu
