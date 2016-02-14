From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 15:20:40 +0800
Subject: [PATCH 1/4] ARM: dts: imx6q-tbs2910: add SATA PHY configuration
In-Reply-To: <1454870073-6506-1-git-send-email-smoch@web.de>
References: <1454870073-6506-1-git-send-email-smoch@web.de>
Message-ID: <20160214072039.GJ6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 07, 2016 at 07:34:30PM +0100, Soeren Moch wrote:
> Configure SATA PHY transmit level, boost, attenuation and equalizer
> parameters for long wire connections. TBS2910 contains a standard SATA
> connector, so devices are typically connected with (longer) SATA cables.
> And explicitly configuring these parameters avoids complaints about
> "not specified" values in boot messages.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>

Applied all, thanks.
