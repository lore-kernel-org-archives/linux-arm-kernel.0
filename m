From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 28 Jul 2014 15:42:06 -0700
Subject: [RFC 4/8] clk: sunxi: add __iomem markings to MMIO pointers
In-Reply-To: <20140728132118.GJ3952@lukather>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <1406519386-4902-5-git-send-email-emilio@elopez.com.ar>
 <20140728132118.GJ3952@lukather>
Message-ID: <20140728224206.4906.35420@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2014-07-28 06:21:18)
> On Mon, Jul 28, 2014 at 12:49:42AM -0300, Emilio L?pez wrote:
> > This commit adds __iomem thoughout the sunxi clock driver, in places
> > where it was ommited. This cleans most of the sparse warnings we
> > are getting here.
> > 
> > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I've applied patches 4 & 5 to clk-next since they are useful fixes and
you have already sent me a pull request for 3.17. Let me know if you
would prefer for me to hold off on them for any reason.

Regards,
Mike

> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
