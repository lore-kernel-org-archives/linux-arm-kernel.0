From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 May 2014 09:29:34 -0500
Subject: [PATCH v2 7/7] ARM: sunxi: dt: add PRCM clk and reset controller
 subdevices
In-Reply-To: <CAGb2v664vFwezKVp+C1UYdsUktRhrZDxjsyf9L=kwVHGCUV=HA@mail.gmail.com>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-8-git-send-email-boris.brezillon@free-electrons.com>
 <20140508031700.GO7047@lukather>
 <CAGb2v664vFwezKVp+C1UYdsUktRhrZDxjsyf9L=kwVHGCUV=HA@mail.gmail.com>
Message-ID: <20140508142934.GV7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 11:40:59AM +0800, Chen-Yu Tsai wrote:
> >> +                     apb0_gates: apb0_gates_clk {
> >> +                             compatible = "allwinner,sun6i-a31-apb0-gates-clk";
> >> +                             #clock-cells = <1>;
> >> +                             clocks = <&apb0>;
> >> +                             clock-output-names = "apb0_pio", "apb0_ir",
> >> +                                             "apb0_timer01", "apb0_p2wi",
> >
> > timer01 ? is this a typo?
> 
> A23 manual lists the clock gate as "r_timer0_1", so I put the name on the wiki.
> Allwinner sun6i code uses "r_tmr" or just "tmr". I see no problem naming this
> clock output as "apb0_timer" though.

Yep, it seems better.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/5e299f63/attachment.sig>
