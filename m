From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Nov 2016 16:42:39 +0100
Subject: [PATCH 2/3] dt-bindings: allow child nodes inside the Tegra BPMP
In-Reply-To: <20160719191442.15439-2-swarren@wwwdotorg.org>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
 <20160719191442.15439-2-swarren@wwwdotorg.org>
Message-ID: <20161115154239.GB22611@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:14:41PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The BPMP implements some services which must be represented by separate
> nodes. For example, it can provide access to certain I2C controllers, and
> the I2C bindings represent each I2C controller as a device tree node.
> Update the binding to describe how the BPMP supports this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Applied, with bpmp-i2c changed to i2c as per Rob's comment.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/3518be8e/attachment.sig>
