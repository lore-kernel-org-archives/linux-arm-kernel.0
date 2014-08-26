From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 08:00:27 +0200
Subject: [PATCH v2 1/3] of: Add NVIDIA Tegra flow controller bindings
In-Reply-To: <53FB7324.9080109@wwwdotorg.org>
References: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
 <53ADE012.5080401@wwwdotorg.org> <53FB7324.9080109@wwwdotorg.org>
Message-ID: <20140826060026.GA15573@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 11:32:20AM -0600, Stephen Warren wrote:
> On 06/27/2014 03:20 PM, Stephen Warren wrote:
> >On 06/27/2014 06:07 AM, Thierry Reding wrote:
> >>From: Thierry Reding <treding@nvidia.com>
> >>
> >>Add device tree bindings for the flow controller found on NVIDIA Tegra
> >>SoCs.
> >>
> >
> >>diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
> >
> >>+NVIDIA Tegra20 Flow Controller
> >>+
> >>+Required properties:
> >>+- compatible: "nvidia,tegra20-flowctrl"
> >>+- reg: Should contain one register range (address and length)
> >>+
> >>+Example:
> >>+
> >>+	flow-controller at 60007000 {
> >>+		compatible = "nvidia,tegra20-flowctrl";
> >>+		reg = <0x60007000 0x1000>;
> >>+	};
> >
> >The bindings all have the same structure. Can we collapse them all into
> >this one file and just list all the valid compatible values and say pick
> >one?
> 
> Thierry, did you post an updated version of this patch? If so, I seem to
> have lost it, so a repost would be good. Thanks.

I don't think I did. If my memory serves me well then I did address your
comments but never sent out the patches. I'll check what the status is.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/36e200a5/attachment-0001.sig>
