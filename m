From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 May 2014 09:51:03 +0200
Subject: [PATCH v2 2/3] drm/panel: add support for EDT panels
In-Reply-To: <35c081171a3d9a9401767601c02a12e266b37dd0.1400103181.git.stefan@agner.ch>
References: <cover.1400103181.git.stefan@agner.ch>
 <35c081171a3d9a9401767601c02a12e266b37dd0.1400103181.git.stefan@agner.ch>
Message-ID: <20140515075102.GE5952@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 11:45:57PM +0200, stefan at agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This panels are sold by Toradex for Colibri T20/T30 and Apalis T30
> evaluation kits.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Panel patches should go to the dri-devel mailing list as well.

Also a patch was posted only yesterday for a panel that seems to be the
exact same one as this, even though the name differs minimally, see:

	https://patchwork.kernel.org/patch/4175251/

Adding Philipp on Cc so you guys can work together whether this is
indeed the same panel. The only differences seem to be in the vertical
front and back porches, but I suspect that either settings will work on
both Tegra and i.MX.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/234b2dad/attachment.sig>
