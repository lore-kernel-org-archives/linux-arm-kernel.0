From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 13:36:08 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: Add dts file for the Orange Pi
 Plus2E SBC
In-Reply-To: <20160903110518.8267-2-hdegoede@redhat.com>
References: <20160903110518.8267-1-hdegoede@redhat.com>
 <20160903110518.8267-2-hdegoede@redhat.com>
Message-ID: <20160905113608.GE6322@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 03, 2016 at 01:05:18PM +0200, Hans de Goede wrote:
> The Orange Pi Plus2E is an extended version of the Orange Pi Pc Plus,
> with 2G RAM and an external gbit ethernet phy.
> 
> Note currently the dts is pretty much empty (except for including the
> pc-plus dts), I've a local patch which enables the emac actually making
> this dts different from the pc-plus one, but that needs the h3 emac
> driver to get merged first.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/7ce3c2d8/attachment-0001.sig>
