From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:03:31 -0700
Subject: [GIT PULL] Allwinner DT additions for 4.1
In-Reply-To: <20150325212124.GA17842@lukather>
References: <20150325212124.GA17842@lukather>
Message-ID: <20150403200331.GT23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 25, 2015 at 02:21:24PM -0700, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> This is the usual pull request for the Allwinner DT changes.
> 
> This branch is merging the clock branch I sent to mike to remove some
> bisection and dependency issues.

We normally prefer to see the external branch sent as a separate pull request,
and Mike should have been cc:d on it.

> The following changes since commit f1017969661dd33ead5ba7c3f4a0793c6611441a:
> 
>   clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6 (2015-03-25 11:46:41 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.1
> 
> for you to fetch changes up to b4f8a14b1262c7e965d6f2412cf7295fbaef0d6f:
> 
>   ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i (2015-03-25 11:50:09 -0700)
> 
> ----------------------------------------------------------------
> Allwinner DT additions for 4.1, take 1
> 
> All the device tree related changes for the 4.1 merge window.
> 
> It has a rather big diffstat, because of a lot of mechanical and harmless
> changes, as described below.
> 
> There is mostly:
>   - The end of the DT relicensing. All our DT should now be under the dual
>     X11/GPL license.
>   - Convertion of all the DT to a label based syntax, instead of duplicating
>     the tree like was done before.

Ugh. This is a huge amount of churn just for the sake of it. It's much
better if these kind of conversions happen over time as the files are
touched for other reasons.

I've merged branches like these before, but I was grumpy when I did those too.

Anyway, I've merged it for now.


-Olof
