From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 7 Jan 2015 15:40:42 +0100
Subject: [PATCH] ARM: dts: tegra20: fix GR3D, DSI unit and reg base
 addresses
In-Reply-To: <1418397559-19646-1-git-send-email-digetx@gmail.com>
References: <1418397559-19646-1-git-send-email-digetx@gmail.com>
Message-ID: <20150107144041.GE1621@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 06:19:19PM +0300, Dmitry Osipenko wrote:
> Commit 58ecb23f64ee ("ARM: tegra: add missing unit addresses to DT") added
> unit address and changed reg base for GR3D and DSI host1x modules, but these
> addresses belongs to GR2D and TVO modules respectively. Fix it by changing
> modules unit and reg base addresses to proper ones.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: 58ecb23f64ee (ARM: tegra: add missing unit addresses to DT)
> Cc: <stable@vger.kernel.org> # v3.13+
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/73b2c502/attachment.sig>
