From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Jul 2014 10:14:04 +0800
Subject: [PATCH] ARM: dts: vf610-colibri: split device tree for carrier
 boards
In-Reply-To: <1405693518-28293-1-git-send-email-stefan@agner.ch>
References: <1405693518-28293-1-git-send-email-stefan@agner.ch>
Message-ID: <20140722021403.GP8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 04:25:18PM +0200, Stefan Agner wrote:
> The Colibri VF61 is a module which needs a carrier board to actually
> run. Different carrier board have different hardware support, hence
> we should reflect this in the device tree files. This patch adds the
> Colibri Evaluation Board, which supports almost all peripherals
> defined in the Colibri standard.
> 
> Also align the compatible naming, file splitting and file naming with
> the scheme which was choosen for the Tegra based modules.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
