From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Jul 2017 16:03:22 +0800
Subject: [RESEND PATCH] ARM: dts: imx: update snvs-poweroff mask
In-Reply-To: <20170704161912.29618-1-m.niestroj@grinn-global.com>
References: <20170704161912.29618-1-m.niestroj@grinn-global.com>
Message-ID: <20170713080321.GO3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 06:19:12PM +0200, Marcin Niestroj wrote:
> From: Guy Shapiro <guy.shapiro@mobi-wize.com>
> 
> Make the syscon-poweroff driver change only the shutdown bits on the
> SNVS_LP control register.
> 
> This change fixes an issue with the RTC wakeup alarm, that was
> previously disabled during power off.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> Reviewed-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Applied, thanks.
