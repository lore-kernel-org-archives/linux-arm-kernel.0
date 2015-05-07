From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 May 2015 19:39:34 +0800
Subject: [PATCH] ARM: imx: using unsigned variable for do_div
In-Reply-To: <1431015411-8432-1-git-send-email-b20788@freescale.com>
References: <1431015411-8432-1-git-send-email-b20788@freescale.com>
Message-ID: <20150507113930.GF3162@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 12:16:51AM +0800, Anson Huang wrote:
> The definition of do_div uses unsigned long long
> variable as its first parameter, better to pass
> a u64 variable as first parameter when calling
> do_div function.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks. 
