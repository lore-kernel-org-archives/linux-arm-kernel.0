From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Feb 2016 20:30:37 +0100
Subject: [PATCH v2] clk: shmobile: r8a7795: Add SD divider support
In-Reply-To: <1454135639-4102-1-git-send-email-dirk.behme@gmail.com>
References: <1454135639-4102-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <20160204193036.GA1958@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2016 at 07:33:59AM +0100, Dirk Behme wrote:
> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Since we don't have UHS support currently, changing the clock is not
really exercised; but the code looks good and if it needs fixing, we can
do it incrementally IMO. What is currently needed works fine on my
Salvator-X for the exposed SD interfaces.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/45685662/attachment.sig>
