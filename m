From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 17 Mar 2014 08:13:59 +0200
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <53258DDA.50005@compulab.co.il>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
 <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il>
Message-ID: <532692A7.7000509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/14 13:41, Dmitry Lifshitz wrote:
> Hi Tomi,
> 
> (resending in the text format)
> 
> Where can I get those unpublished omap5 and omap5-uevm display patches
> to test the video out with this patch?
> I'll appreciate your assistance in additional setup (like required uEvm
> .dts changes and DSI panel connection short guide).

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
work/dss-dt-pyra

I've since added omap5 hdmi support, so omap5-uevm's hdmi output works
on that branch.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/880b9b13/attachment.sig>
