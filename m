From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Sep 2011 21:34:51 -0400 (EDT)
Subject: [PATCH] ARM: realview-eb11mp: fix map_desc alignment
In-Reply-To: <1317343578-5307-1-git-send-email-robherring2@gmail.com>
References: <4E84E0CA.2050905@gmail.com>
	<1317343578-5307-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1109292134060.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2011, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> REALVIEW_EB11MP_GIC_CPU_BASE is not 4KB aligned which causes an
> overlapping mapping. Use REALVIEW_EB11MP_SCU_BASE instead which is
> aligned.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> Nico,
> 
> Here's another one. I visually checked the remaining Realview platforms and
> think they are fine.

Thanks.


Nicolas
