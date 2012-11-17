From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Nov 2012 16:44:25 -0800
Subject: [PATCH v5 02/10] pinctrl: single: support gpio request and free
In-Reply-To: <1352968600-15345-3-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121117004425.GO6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121115 00:39]:
> Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
> Each pin binds to one register. A lot of pins could be configured
> as gpio.
> 
> GPIO range is defined as a child node of pinmux in .dtsi file. If those
> pins are with the same gpio function configuration in the pinmux
> register, they could be defined in the same GPIO range. For this new
> child node, two properties are used.
> 
> reg = <the start of pinmux register in range, size of range>
> 
> pinctrl-single,gpio: <gpio base in range, the gpio function of the range
> 		in the pinmux register>
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Acked-by: Tony Lindgren <tony@atomide.com>
