From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 21:05:32 +0100
Subject: [PATCH v2 8/9] ASoC: sunxi: allow the analog codec driver to be
 built on ARM64
In-Reply-To: <20170126154859.55855-9-icenowy@aosc.xyz>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-9-icenowy@aosc.xyz>
Message-ID: <20170127200532.pemk36hwyzkun3i5@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:48:58PM +0800, Icenowy Zheng wrote:
> As the 64-bit Allwinner H5 SoC has the same analog codec part (also the
> same digital part) as H3, enable the driver to be built on ARM64
> Allwinner platform, so that it can be used on H5.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/82707ab0/attachment.sig>
