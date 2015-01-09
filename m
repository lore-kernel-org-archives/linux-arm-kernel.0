From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 9 Jan 2015 12:06:36 +0100
Subject: [PATCHv2 8/8] arm: dts: tegra: update isl29028 compatible string
 to use isil vendor prefix
In-Reply-To: <8cfd0ac11713262036dca415e59e56508fb07c3c.1418763328.git.arno@natisbad.org>
References: <cover.1418763328.git.arno@natisbad.org>
 <8cfd0ac11713262036dca415e59e56508fb07c3c.1418763328.git.arno@natisbad.org>
Message-ID: <20150109110635.GA16465@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 10:21:16PM +0100, Arnaud Ebalard wrote:
> 
> "isil" and "isl" prefixes are used at various locations inside the kernel
> to reference Intersil corporation. This patch is part of a series fixing
> those locations were "isl" is used in compatible strings to use the now
> expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
> version).
> 
> Note: isl29028 is an I2C device so the patch does not in fact currently
> depend on the introduction of "isil"-based compatible string in isl29028
> driver because I2C core does not check the prefix yet.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to the for-3.20/dt branch, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/78b6189e/attachment.sig>
