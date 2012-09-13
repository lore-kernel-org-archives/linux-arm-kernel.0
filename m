From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2012 13:06:31 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: Add support RTC
In-Reply-To: <1347505841-8594-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1347505841-8594-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <20120913040629.GA23861@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 12:10:41PM +0900, Nobuhiro Iwamatsu wrote:
> The armadillo800eva has S35390A which is RTC. This is controlled
> using I2C of GPIO.
> This commit supports RTC of armadillo800eva.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Hi Iwamatsu-san,

could you please either update this patch or provide a follow-up
patch to update the defconfig so the S35390A is enabled?

"make savedefconfig" may be useful for this.
