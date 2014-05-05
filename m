From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 May 2014 23:00:26 -0500
Subject: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140505040026.GB11606@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 05:57:14PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v10 of the sunxi-mmc patch-set David Lanzend?rfer and I have been
> working on, this has some minor changes since v9, the plan for upstreaming is
> still the same:
> 
> The first 2 patches are depenencies which should go in through the clk tree,
> Mike can you pick these 2 up please ?  :
> 
> "clk: sunxi: factors: automatic reparenting support"
> Is uncontroversial and has been favorably reviewed by various people.
> 
> "clk: sunxi: Implement MMC phase control"
> Is somewhat more controversial as there has been lots of discussion about
> adding a generic phase control method to the clk framework. The problem is
> that there has been a lot of talk about such a generic phase control method
> but not a single patch. Therefor I would like to move forwards with using
> a platform specific method for now. I hereby promise that once we've a generic
> method I'll write patches to convert the sunxi code to that method.
> 
> The third patch is the patch adding the actual mmc driver and should go in
> through the mmc tree.
> 
> All the other patches are devicetree patches hooking things up, and should
> go upstream through Maxime's sunxi-dt tree.

Applied patches 4 to 14.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140504/69e590f7/attachment.sig>
