From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 20:31:42 +0200
Subject: [PATCH 3/8] ARM: dts: sun8i: reference-design-tablet: Add
 gsl1680 touchscreen node
In-Reply-To: <1470685398-14568-3-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20160822183142.GY7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 09:43:13PM +0200, Hans de Goede wrote:
> Almost all sun8i tablets use a gsl1680 touchscreen controller, so add
> a node describing it to reference-design-tablet.dtsi.
> 
> Almost all, but not all, so mark it as disabled by default (dts files
> will also need to supply a firmware-name and resolution info).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied the first three patches, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/dd6567ad/attachment.sig>
