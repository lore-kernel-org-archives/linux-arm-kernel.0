From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 28 Mar 2018 14:11:42 +0200
Subject: [PATCHv2] pinctrl: samsung: add pin_dbg_show callback for debugfs
In-Reply-To: <20180327135801.9556-1-parkch98@gmail.com>
References: <20180327135801.9556-1-parkch98@gmail.com>
 <CGME20180328121148epcas2p2a498fce663d34c8c3caf38e15d6e68c3@epcas2p2.samsung.com>
Message-ID: <61255506-cb75-3628-4ebb-7dec9d48219d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 03:58 PM, Chanho Park wrote:
> This patch adds a samsung_pin_dbg_show function to implement the
> pin_dbg_show callback function which can be used to show pin
> confuration values. Basically, it can show pin setting values by
> accessing the "pins" node like below:
> 
> $ cat pins
> pin 0 (gpy7-0)  CON(0x0) DAT(0x1) PUD(0x1) DRV(0x0) CON_PDN(0x0) PUD_PDN(0x0)
> 
> Signed-off-by: Chanho Park <parkch98@gmail.com>

Thank you for the patch. On exynos5433-tm2

Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
