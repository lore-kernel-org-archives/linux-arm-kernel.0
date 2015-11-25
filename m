From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 25 Nov 2015 11:07:43 +0800
Subject: [PATCH] mach-imx/mach-imx6ul.c: proper constness with __initconst
In-Reply-To: <alpine.LFD.2.20.1511212024220.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511212024220.22569@knanqh.ubzr>
Message-ID: <20151125030743.GD11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 08:35:31PM -0500, Nicolas Pitre wrote:
> Both the pointer array and the pointed data have to be const when using
> __initconst to be correct.  This also fixes LTO builds that otherwise 
> fail with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Applied, thanks.
