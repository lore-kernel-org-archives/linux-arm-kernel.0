From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 May 2014 18:02:55 +0100
Subject: [PATCHv4 1/2] dt/bindings: Add the DT binding documentation for
 endianness
In-Reply-To: <20140509163243.GD16418@e106331-lin.cambridge.arm.com>
References: <1399601073-19278-1-git-send-email-Li.Xiubo@freescale.com>
 <1399601073-19278-2-git-send-email-Li.Xiubo@freescale.com>
 <20140509163243.GD16418@e106331-lin.cambridge.arm.com>
Message-ID: <20140509170255.GR12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 05:32:43PM +0100, Mark Rutland wrote:
> On Fri, May 09, 2014 at 03:04:32AM +0100, Xiubo Li wrote:

> > {big,little}-endian{,-*}: these are boolean properties, if absent
> > meaning that the CPU and the Device are in the same endianness mode.

> That's not really true though. A device might usually be little-endian,
> regardless of the endianness of a CPU. Some vendors may integrate it as
> big-endian after a binding is added, and in the absence of a specified
> endianness a driver is likely to assume LE.

The default should be device specific rather than binding specific.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/5806baf1/attachment.sig>
