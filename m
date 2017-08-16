From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 16 Aug 2017 22:53:32 +0200
Subject: [PATCH] nokia n900: update dts with camera support
In-Reply-To: <20170815220349.GA15441@amd>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
Message-ID: <20170816205332.rqcuenvuxfs5jvuw@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 16, 2017 at 12:03:49AM +0200, Pavel Machek wrote:
> diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> index 852041a..aade681 100644
> --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> @@ -119,6 +119,8 @@ Optional endpoint properties
>    as 0 (normal). This property is valid for serial busses only.
>  - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
>    with CCP2, for instance.
> +- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - inverted
> +- crc: crc is in use

booleans in DT are not done with <0> and <1>, but as properties without
values. True = property exists, False = property does not exist.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170816/5d8992fb/attachment.sig>
