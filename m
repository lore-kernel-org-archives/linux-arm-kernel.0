From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 4 Jan 2015 00:39:50 +0100
Subject: [PATCH V3] ARM: dts: am57xx-beagle-x15: Add GPIO controlled fan
 node
In-Reply-To: <1420309826-7904-1-git-send-email-nm@ti.com>
References: <1420309826-7904-1-git-send-email-nm@ti.com>
Message-ID: <20150103233949.GA4108@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On Sat, Jan 03, 2015 at 12:30:26PM -0600, Nishanth Menon wrote:
> [...]
> +		gpio-fan,speed-map = <0    0
> +				      13000 1>;
> [...]

iirc DT maintainers prefer this format:

gpio-fan,speed-map = <0     0>,
                     <13000 1>;

This should result in the same .dtb, but is a bit easier to read.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150104/f9e39628/attachment.sig>
