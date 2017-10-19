From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Oct 2017 10:25:03 +0200
Subject: [PATCH] arm64: defconfig: Enable Tegra PCI controller
In-Reply-To: <20171018144620.4699-1-tuomas.tynkkynen@iki.fi>
References: <20171018144620.4699-1-tuomas.tynkkynen@iki.fi>
Message-ID: <20171019082503.GA9005@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 05:46:20PM +0300, Tuomas Tynkkynen wrote:
> The driver has supported the 64-bit Tegra210 for a while now, so enable
> it in the defconfig.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> ---
> I didn't personally test this but got a report from our distro users
> that it works.
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171019/9961f57e/attachment.sig>
