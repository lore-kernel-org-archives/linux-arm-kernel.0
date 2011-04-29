From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 00:04:08 -0700
Subject: [PATCH 4/9] ARM: zImage: the page table memory must be
	considered before relocation
In-Reply-To: <1304031024-5121-5-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-5-git-send-email-nico@fluxnic.net>
Message-ID: <20110429070408.GQ3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110428 15:47]:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> For correctness, the initial page table located right before the
> decompressed kernel should be considered when determining if relocation
> is required.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com>
