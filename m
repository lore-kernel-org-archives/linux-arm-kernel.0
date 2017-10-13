From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Oct 2017 09:58:51 +0100
Subject: [PATCH/RFC 3/5] mfd: bd9571mwv: Allow DDR Backup Power register
 access
In-Reply-To: <1507649178-31473-4-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20171013085851.ljvgmyd6ei2tv5fw@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:

> Enable read/write access to the BD9571MWV_BKUP_MODE_CNT register, which
> is a.o. used to configure DDR Backup Power.

a.o.?  That's a new one on me.

Please ensure commit logs are clear for *everyone* to read/understand
by using descriptive and expanded (rather than shorten) terms.

Code looks fine though, so once fixed:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
