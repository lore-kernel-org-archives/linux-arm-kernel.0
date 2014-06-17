From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 14:09:44 +0200
Subject: [PATCH v3 1/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <539F6318.5010306@wwwdotorg.org>
References: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
 <539F6318.5010306@wwwdotorg.org>
Message-ID: <20140617120943.GD18816@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 03:35:20PM -0600, Stephen Warren wrote:
> On 06/16/2014 08:57 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This patch adds the device tree binding documentation for the XUSB pad
> > controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
> > capabilities.
> 
> This looks fine to me, with one issue below:
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
> 
> > +Required properties:
> > +--------------------
> 
> > +- #address-cells: Should be 0.
> > +- #size-cells: Should be 0.
> 
> I don't think those properties are needed. If they are, a value of 0 for
> both doesn't seem useful. I assume those two lines should just be
> deleted, and also from the example below.
> 
> Assuming I take this through the Tegra tree, If this is the only issue,
> I can delete those lines when applying.

I've just sent a v4 including these changes along with a fix for the bug
that Mikko pointed out.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/c46eb25f/attachment.sig>
