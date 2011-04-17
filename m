From: sudeepholla.maillist@gmail.com (Sudeep K N)
Date: Sun, 17 Apr 2011 20:34:53 +0530
Subject: About enable L2 cache in Linux kernel
In-Reply-To: <BANLkTi=pTm+tgn88CQ8GGOoEZPAN_o4nzw@mail.gmail.com>
References: <BANLkTinTB=BmybmAGCRAbS9+nsLbXwBvkg@mail.gmail.com>
	<BANLkTi=pTm+tgn88CQ8GGOoEZPAN_o4nzw@mail.gmail.com>
Message-ID: <BANLkTimdwYp4_kJmuetLhskCo_bApxmsyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Liu,

Linux kernel skips L2 cache enable operation if its running in non-secure
mode as it needs to be enabled by boot code running in secure mode only.
Write access to L2X0_AUX_CTRL register in non-secure will fault.

--
Regards,
Sudeep
