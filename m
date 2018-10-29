From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:15:08 +0100
Subject: [PATCH v3 00/25] drm/sun4i: Allwinner A64 MIPI-DSI support
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
Message-ID: <20181029091508.gyhn2m5fnbucvb34@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:13:19PM +0530, Jagan Teki wrote:
> This series fixed the issues related to work DSI on 2-lane panel
> which is reported on previous version[1].
> 
> Few comments from previous version still in discussion, but I just
> send this version just to group all working changes together.
> anyway I will fix in this in next version if any.
> 
> PLL_MIPI min rate is still weird, I tried many possible dclock rate
> from panel driver to satisfy manual suggested min rate 500MHz but
> none working so eventually moved 300MHz. any inputs on this area
> are welcome.
> 
> All these changes are tested in 2-lane, 4-lane MIPI-DSI panels.
> 
> If anyone wants to test, use this repo [2] with WIP-A64-DSI branch.

A changelog would be nice here, and usually you shouldn't send a new
version while there is ongoing discussion on the previous version.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/edf87041/attachment-0001.sig>
