From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 09:46:43 +0200
Subject: [PATCH 0/1] ARM: dts: sunxi: Fix simplefb not working in 4.7-rc1
In-Reply-To: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
References: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160609074643.GA5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sat, Jun 04, 2016 at 08:05:23PM +0200, Hans de Goede wrote:
> Hi Maxime,
> 
> While testing 4.7-rc1 / linux-sunxi/sunxi-next on a A10s I noticed that
> hdmi out is no longer working (screen goes black when the kernel turns
> of unused clocks).
> 
> This is caused by the dtsi for sun4i / sun5i / sun7i based boards now
> listing pll3, without pll3 being added to the clocks list for the
> simplefb nodes.

Why not do just that then? It's more appropriate for a fix imho.

Thanks! (and sorry for the breakage)
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/c47efccb/attachment-0001.sig>
