From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 14:35:02 +0100
Subject: [PATCH] ARM: tegra: document which Dalmore revisions are supported
In-Reply-To: <1389035749-15261-1-git-send-email-swarren@wwwdotorg.org>
References: <1389035749-15261-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140108133501.GC1592@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 12:15:49PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> There are a number of revisions of the Dalmore board, each with a variety
> of incompatible SW-visible HW changes. The Dalmore DT file in the kernel
> only supports HW revision A04. Document this in the DT file.
> 
> Reported-by: Paul Walmsley <pwalmsley@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/dfae440f/attachment-0001.sig>
