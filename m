From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 May 2015 21:24:40 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun7i: Add uart4 support for BananaPro,
 disable uart2
In-Reply-To: <1432305184-8589-2-git-send-email-hdegoede@redhat.com>
References: <1432305184-8589-1-git-send-email-hdegoede@redhat.com>
 <1432305184-8589-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150522192440.GH8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 04:33:04PM +0200, Hans de Goede wrote:
> From: Michael Ring <mail@michael-ring.org>
> 
> The BananaPro uses uart4 for the default rx/tx pins on the 40 pins connector,
> so enable uart4.
> 
> Uart2 is also available at the bananapro io-pins, but like on the bananapi
> the primary function of the pins is to act as gpios, see:
> http://forum.lemaker.org/forum.php?mod=viewthread&tid=10852
> 
> Remove the uart2 node, people who want to use uart2 can do so with a
> devicetree-overlay.
> 
> Signed-off-by: Michael Ring <mail@michael-ring.org>
> [hdegoede at redhat.com: Remove uart2 node]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied both, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/93eda0c6/attachment.sig>
