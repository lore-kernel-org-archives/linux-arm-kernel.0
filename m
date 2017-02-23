From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Feb 2017 11:57:54 +0800
Subject: [PATCH v2 2/2] mfd: axp20x: Add support for dts property "xpowers,
 master-mode"
In-Reply-To: <ef82cd5bbea5a5eedcafd3f57e7b7409dd9b4b5e.1487791329.git.rask@formelder.dk>
References: <cover.1487791328.git.rask@formelder.dk>
 <ef82cd5bbea5a5eedcafd3f57e7b7409dd9b4b5e.1487791329.git.rask@formelder.dk>
Message-ID: <CAGb2v66=fipED2pDkHJWZG4RPVML+h8h7=n=M2y-5oW9xgu+uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 3:42 AM, Rask Ingemann Lambertsen
<rask@formelder.dk> wrote:
> commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
> was intended to fix the case where a board uses an AXP806 in slave mode,
> but the boot loader leaves it in master mode for lack of AXP806 support.
> But now the driver breaks on boards where the PMIC is operating in master
> mode. This patch lets the driver use the new device tree property
> "xpowers,master-mode" to set the correct operating mode for the board.
>
> Fixes: 8824ee857348 ("mfd: axp20x: Add support for AXP806 PMIC")
> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>

Acked-by: Chen-Yu Tsai <wens@csie.org>
