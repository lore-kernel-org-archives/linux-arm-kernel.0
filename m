From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 26 Sep 2013 20:14:16 +0200
Subject: [RFC 3/3] Samsung: DT: Add Device tree for S5PC110/S5PV210 Boards
In-Reply-To: <1380214769-7685-4-git-send-email-m.krawczuk@partner.samsung.com>
References: <1380214769-7685-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1380214769-7685-4-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <4009668.rmW0ykQNyc@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mateusz,

On Thursday, September 26, 2013 06:59:29 PM Mateusz Krawczuk wrote:
> Add DTS for s5pc110 boards: goni, aquila, smdkc110
> s5pv210: smdkv210, tiny210
> Torbreck is replaced by FriendlyARM Tiny210 board.

Could you please explain what do you mean by "replaced" here?

Looking at the current board code it should be pretty easy to add
device tree support for Torbreck if needed (it is just a subset of
smdkc110 support + mmc). Then you would have all mach-s5pv210 boards
covered by the device tree and could plan for the removal of non-DT
code in the near future.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
