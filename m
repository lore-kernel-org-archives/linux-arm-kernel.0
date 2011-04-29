From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Apr 2011 23:58:27 -0700
Subject: [PATCH 1/9] ARM: zImage: make sure the stack is 64-bit aligned
In-Reply-To: <1304031024-5121-2-git-send-email-nico@fluxnic.net>
References: <1304031024-5121-1-git-send-email-nico@fluxnic.net>
	<1304031024-5121-2-git-send-email-nico@fluxnic.net>
Message-ID: <20110429065826.GO3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110428 15:47]:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> With ARMv5+ and EABI, the compiler expects a 64-bit aligned stack so
> instructions like STRD and LDRD can be used.  Without this, mysterious
> boot failures were seen semi randomly with the LZMA decompressor.
> 
> While at it, let's align .bss as well.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> CC: stable at kernel.org

Acked-by: Tony Lindgren <tony@atomide.com>
