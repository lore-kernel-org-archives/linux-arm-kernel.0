From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 20:59:02 +0800
Subject: [PATCH 1/2] ARM: dts: TS-4800: drop uart rts/cts pin reservations
In-Reply-To: <1450387013-3532-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1450387013-3532-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <20151221125902.GJ4703@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 04:16:52PM -0500, Damien Riegel wrote:
> These pins are actually not routed for UARTs, they should not be
> reserved.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Applied both, thanks.
