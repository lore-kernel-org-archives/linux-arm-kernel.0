From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Apr 2015 20:19:01 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun5i: Add broken-hpi property for
 Utoo-P66 eMMC
In-Reply-To: <1427901984-26469-2-git-send-email-hdegoede@redhat.com>
References: <1427901984-26469-1-git-send-email-hdegoede@redhat.com>
 <1427901984-26469-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150402181901.GA14618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 05:26:24PM +0200, Hans de Goede wrote:
> The eMMC on the A13 based Utoo-P66 tablet does not properly support hpi,
> and trying to enable it results in the eMMC not working, so add a child-node
> describing the eMMC, and set the broken-hpi property on it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/c938966b/attachment.sig>
