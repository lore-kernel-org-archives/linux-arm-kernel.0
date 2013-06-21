From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Jun 2013 12:24:46 +0200
Subject: [PATCHv3 08/11] arm: mvebu: the MPIC now provides MSI controller
 features
In-Reply-To: <1371660979-21588-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621102445.GF12441@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 06:56:16PM +0200, Thomas Petazzoni wrote:
> Adds the 'msi-controller' property to the main interrupt controller
> Device Tree node, to indicate that it can now behave as a MSI
> controller.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/daacaf43/attachment.sig>
