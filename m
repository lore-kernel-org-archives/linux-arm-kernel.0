From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 22 Apr 2016 13:46:42 +0200
Subject: [PATCH v2] ARM: dts: tegra: correct Beaver pinmux
In-Reply-To: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
References: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
Message-ID: <20160422114642.GD9047@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 08:18:30PM +0100, Lucas Stach wrote:
> Update pinmux to get rid of invalid uses of the rsvd1 function, which lead
> to the mux settings on those pins to not be applied.
> 
> Also add correct drive settings, derived from the Tegra3 TRM, for SDIO1,
> which makes some more SD-cards work.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  arch/arm/boot/dts/tegra30-beaver.dts | 39 ++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 15 deletions(-)

Applied, thanks.

Stephen, you had looked at this before. If you're happy with it, would
you mind providing an Acked-by? I can apply it after the fact.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/c9a7b252/attachment.sig>
