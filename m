From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 7 May 2012 09:08:39 +0800
Subject: [PATCH 4/9] mmc: mxs-mmc: adopt pinctrl support
In-Reply-To: <87zk9lqojf.fsf@laptop.org>
References: <1336318505-27043-1-git-send-email-shawn.guo@linaro.org>
 <1336318505-27043-5-git-send-email-shawn.guo@linaro.org>
 <87zk9lqojf.fsf@laptop.org>
Message-ID: <20120507010837.GF19389@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2012 at 12:09:40PM -0400, Chris Ball wrote:
> Hi,
> 
> Patch looks fine -- perhaps you could copy the explanation about the
> dummy pinctrl state for non-DT boards from your series introduction
> into this commit message, since the commit messages go into git and
> the series description doesn't?  Thanks.
> 
Yeah, I thought about doing that.  But after a second thought, I did
not do because I think device drivers should not care about these
underneath details.  Pinctrl subsystem and platform should just sort
these out and make them invisible to device drivers.

> Acked-by: Chris Ball <cjb@laptop.org>
> 
Thanks, Chris.

-- 
Regards,
Shawn
