From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Jan 2015 17:47:53 +0100
Subject: [PATCH v2 3/3] ARM: dts: sun8i: Add dts file for Ippo Q8H v1.2
 tablets
In-Reply-To: <1421145872-17828-3-git-send-email-hdegoede@redhat.com>
References: <1421145872-17828-1-git-send-email-hdegoede@redhat.com>
 <1421145872-17828-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150113164753.GC4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 11:44:32AM +0100, Hans de Goede wrote:
> The Ippo Q8H v1.2 is almost identical to the v5, still it needs a separate
> dtb file since some gpio-s surrounding the wlan/bluetooth are different,
> it uses different camera sensors, and different DRAM timings.
> 
> Note that atm neither the wlan/bluetooth nor the camera are supported, so
> atm their is no difference between the dts files, but because of the different
> DRAM timings there are already separate u-boot configs for the 2 different
> versions, and the 1.2 config refers to sun8i-a23-ippo-q8h-v1.2.dtb to be
> future proof, so we need to provide a sun8i-a23-ippo-q8h-v1.2.dtb file.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/2e5bb2e6/attachment.sig>
