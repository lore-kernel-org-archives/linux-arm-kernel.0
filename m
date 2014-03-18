From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 07:29:34 +0200
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <53270510.1030301@compulab.co.il>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
 <532037E0.1080309@ti.com> <53258DDA.50005@compulab.co.il>
 <532692A7.7000509@ti.com> <5326F71C.1060602@compulab.co.il>
 <5326F893.3080607@ti.com> <53270510.1030301@compulab.co.il>
Message-ID: <5327D9BE.80503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/14 16:22, Dmitry Lifshitz wrote:
> Hi Tomi,
> 
> Unfortunately, I have a lack of experience with DT DSS stuff.
> 
> How should I define the endpoints and the connector in my case?
> Please, could you provide some reference.

See Documentation/devicetree/bindings/media/video-interfaces.txt for a
description of the ports and endpoints.

If your board is similar to uevm except you don't have the tpd12s015,
then you just need to remove the tpd12s015 from the .dts file, and
connect the OMAP's HDMI output directly to the connector.

> Regarding omapfb, is it sufficient to turn it on in the Kernel config?

Yes.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/1e2da321/attachment.sig>
