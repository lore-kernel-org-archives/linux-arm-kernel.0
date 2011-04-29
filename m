From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 00:05:03 -0700
Subject: [PATCH 7/9] ARM: zImage: don't ignore error returned from
	decompress()
In-Reply-To: <1304031024-5121-8-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-8-git-send-email-nico@fluxnic.net>
Message-ID: <20110429070503.GR3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110428 15:47]:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> If decompress() returns an error without calling error(), we must
> not attempt to boot the resulting kernel.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Tony Lindgren <tony@atomide.com>
