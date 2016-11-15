From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Nov 2016 16:46:07 +0100
Subject: [PATCH 3/3] dt-bindings: add Tegra186 BPMP I2C binding
In-Reply-To: <20160719191442.15439-3-swarren@wwwdotorg.org>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
 <20160719191442.15439-3-swarren@wwwdotorg.org>
Message-ID: <20161115154607.GC22611@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:14:42PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> In Tegra186, the BPMP (Boot and Power Management Processor) owns certain
> HW devices, such as the I2C controller for the power management I2C bus.
> Software running on other CPUs must perform IPC to the BPMP in order to
> execute transactions on that I2C bus. This binding describes an I2C bus
> that is accessed in such a fashion.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  .../bindings/i2c/nvidia,tegra186-bpmp-i2c.txt      | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,tegra186-bpmp-i2c.txt

I ended up cherry-picking this commit from U-Boot, which already had
both of the comments addressed that were discussed here. I also took the
liberty of adding Jon's Acked-by from this thread since it's effectively
the same commit.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/27395f3b/attachment.sig>
