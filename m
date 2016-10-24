From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Oct 2016 15:17:03 +0200
Subject: [PATCH v5 3/7] drm: sunxi: add DE2 HDMI support
In-Reply-To: <36bd5454897c8ab77749e0294e4a4ecc2450dd12.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <36bd5454897c8ab77749e0294e4a4ecc2450dd12.1477142934.git.moinejf@free.fr>
Message-ID: <20161024131703.exrqt5cqrepwuvkp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 21, 2016 at 10:08:06AM +0200, Jean-Francois Moine wrote:
> This patch adds a HDMI driver to the DE2 based Allwinner's SoCs
> as A83T and H3.
> Audio and video are supported.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Output from checkpatch:
total: 26 errors, 31 warnings, 70 checks, 1458 lines checked

Please run checkpatch before sending your patches.

Apart from that, this looks an awful lot like the designware HDMI
controller, for which a driver already exists. Any reason to create a
new driver from scratch?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/aa53ff74/attachment-0001.sig>
