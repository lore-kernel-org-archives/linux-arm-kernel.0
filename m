From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 May 2015 13:56:47 +0200
Subject: [PATCH 2/9] ARM: tegra: fix hda2codec_2x clock name for Tegra30
In-Reply-To: <4c052b5a83e74b1571409a0a2cee1cc2832095c2.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
 <4c052b5a83e74b1571409a0a2cee1cc2832095c2.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <20150505115645.GB30501@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:35:57PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  drivers/clk/tegra/clk-tegra30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think this isn't technically required because we're always getting the
clocks via DT phandles. The whole devclks table should be obsolete since
a couple of releases now, but might as well keep it correct until we've
determined that it is safe to remove.

Added a short commit message and applied this for v4.2.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/71df1047/attachment-0001.sig>
