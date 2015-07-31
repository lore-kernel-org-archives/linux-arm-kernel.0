From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 31 Jul 2015 13:21:12 +0200
Subject: [PATCH v2] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
In-Reply-To: <1436539214-21536-1-git-send-email-anuragku@xilinx.com>
References: <1436539214-21536-1-git-send-email-anuragku@xilinx.com>
Message-ID: <20150731112111.GM1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 08:10:14PM +0530, Anurag Kumar Vulisha wrote:
> Cadence 1.0 version has bugs which have been fixed in the cadence 1.4 version.
> This patch removes the quirks present in the driver for cadence 1.4 version.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/5c0aec61/attachment.sig>
