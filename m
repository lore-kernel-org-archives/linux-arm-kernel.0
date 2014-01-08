From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 16:18:46 +0100
Subject: [PATCH 1/2] ARM: tegra: enable LCD panel on Seaboard
In-Reply-To: <1389138437-4686-1-git-send-email-swarren@wwwdotorg.org>
References: <1389138437-4686-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140108151845.GE21974@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 04:47:16PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Seaboard uses a CLAA101WA01A LCD panel. Enable the relevant display
> controller, backlight, and regulators.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-seaboard.dts | 55 +++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)

I think this patch needs s/chungwa/chunghwa/, but other than that it
looks good to me:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/5822c78c/attachment-0001.sig>
