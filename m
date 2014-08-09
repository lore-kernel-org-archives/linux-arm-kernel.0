From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Aug 2014 08:22:49 -0700
Subject: [PATCH RESEND] ARM: dts: Fix the sort ordering of EHCI and HSIC
 in rk3288.dtsi
In-Reply-To: <14819563.gjVG8jMF0E@diego>
References: <14819563.gjVG8jMF0E@diego>
Message-ID: <20140809152249.GA5053@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 05:44:19PM +0200, Heiko St?bner wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> The EHCI and HSIC device tree nodes were added in the wrong place.
> Fix them.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Sorry for the double-post. I messed something up when sending the original
> which made it look like it came from Doug instead of me.

Applied, thanks.


-Olof
