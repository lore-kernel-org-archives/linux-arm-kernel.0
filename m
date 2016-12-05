From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Dec 2016 10:24:53 +0800
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <3937871.l5gZt4hBke@wuerfel>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <1476361881-19685-2-git-send-email-jun.nie@linaro.org>
 <a243d381-f7ab-abed-ca21-f0951abb04fd@arm.com>
 <3937871.l5gZt4hBke@wuerfel>
Message-ID: <20161205022451.GA2749@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Dec 02, 2016 at 09:28:58PM +0100, Arnd Bergmann wrote:
> Given that there is any concern about the patch now, and the merge
> window is almost open, I'm moving both patches to the
> next/fixes-non-critical branch and will merge it for v4.10 instead
> of sending it for v4.9.
> 
> If you end up deciding that the patch is wrong, please follow up
> with a fix on top. Once the situation is resolved and the patch
> merged upstream, feel free to ask stable at vger.kernel.org for a
> backport to stable kernels to get it into v4.9.x.

The patch is correct, though it can be cleaned up a bit further per
Marc's suggestion.  Since we now have 4.9-rc8, I'm wondering if we can
still get this into 4.9 to save the stable kernel backport.

I sent you a cleanup patch on top of this one yesterday.  If you like,
I can quickly resend the patch with the cleanup squashed.

Thanks,
Shawn
