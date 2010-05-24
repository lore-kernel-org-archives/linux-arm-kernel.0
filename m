From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 24 May 2010 10:45:05 +0100
Subject: [PATCH 03/20] mtd: pxa3xx_nand: remove the flash info in
	driver structure
In-Reply-To: <AANLkTil9Toz4DU7YJ2B3Qtw3S1LCr90R7tlri7KC_NCC@mail.gmail.com>
References: <AANLkTikU9yabdwx_a5SzpC11v9nowW_zglNHLaswaToB@mail.gmail.com>
	<4BFA2A02.2040605@compulab.co.il>
	<AANLkTil9Toz4DU7YJ2B3Qtw3S1LCr90R7tlri7KC_NCC@mail.gmail.com>
Message-ID: <1274694305.20576.2854.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-24 at 09:41 +0100, Lei Wen wrote:
> For this patch set change the original c file greatly, more than half
> of original code is changed,
> I cannot create a patch for each change. (If so, this patch set would
> grow to be a very large one. Maybe 30+?)

Yes you can -- large patch sets are fine. If email becomes cumbersome,
feel free to just publish it as a git tree. Once Mike approves I can
pull from it.

Let me have a SSH public key if you want to be able to publish a git
tree on git.infradead.org.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
