From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 May 2013 13:08:21 -0700
Subject: [PATCH 0/3] ARM: imx/mxs: fixes for 3.10-rc1
In-Reply-To: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
References: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130509200821.GA21293@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 09:05:52PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> It seems that you will have a few other fixes to send mainline for
> 3.10-rc1 inclusion before merge window closes.  In that case, can you
> please include the following 3 which fix imx/mxs compile errors that
> are currently seen on mainline?

Thanks, applied all three. For framebuffer fixes, it seems that we tend to
route them through Andrew Morton for the most part, so future patches should
probably go through him.


-Olof
