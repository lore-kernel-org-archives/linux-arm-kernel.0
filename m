From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jun 2011 03:46:49 -0700
Subject: [PATCH 2/3] ARM: zImage: Allow the appending of a device tree
	binary
In-Reply-To: <1307858800-16712-3-git-send-email-nicolas.pitre@linaro.org>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<1307858800-16712-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110613104648.GD10951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110611 23:03]:
> From: John Bonesio <bones@secretlab.ca>
> 
> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> [nico: adjusted to latest zImage changes plus additional cleanups]
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Looks like this rebased version has two nice improvments: It uses r5
instead of lr, and keeps stack usable early on :)

Acked-by: Tony Lindgren <tony@atomide.com>
