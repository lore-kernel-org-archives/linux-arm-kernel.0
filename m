From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Feb 2014 10:20:47 +0100
Subject: [PATCH RESEND] ARM: imx6: build pm-imx6q.c independently of
 CONFIG_PM
In-Reply-To: <20140226072833.GA23892@S2101-09.ap.freescale.net>
References: <1392690905-16839-1-git-send-email-shawn.guo@linaro.org>
 <201402252046.04144.arnd@arndb.de>
 <20140226072833.GA23892@S2101-09.ap.freescale.net>
Message-ID: <5787995.zDVCNExNtr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014 15:28:35 Shawn Guo wrote:
> 
> The error is only seen on the linux-next, and partially caused by the
> resolution for the conflict between this patch and the ones I queued for
> 3.15.  I'm rebasing my imx-soc-3.15 branch to 3.14-rc4, so that the
> conflict can be solved on my branch in a cleaner way, which will help
> fix the error here.  So hopefully, in the next build of linux-next, the
> error will disappear.

Ok, thanks a lot!

	Arnd
