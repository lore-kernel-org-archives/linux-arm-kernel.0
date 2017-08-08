From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Aug 2017 13:57:52 +0200
Subject: Nokia N900 camera support in linux-next
Message-ID: <20170808115752.GA19585@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Most of CSI-1 / N900 camera support is there in linux-next tree:
patches marked "n" are in, unmarked patches are only in Sakari's tree.

Is there something I can do to help merging patches to linux-next? We
are quite close, and it would be nice to have camera support in v4.14...

Thanks,
								Pavel

369e74605f768efa74483ab08e706347756e2092 omap3isp: Skip CSI-2 receiver initialisation in CCP2 configuratio$
8f7dc67fed42fa3d36f590fb42769bcf1513e37a omap3isp: Correctly put the last iterated endpoint fwnode always
d3e8774ca1119c264886b84d49ef28da0b459bb4 omap3isp: Always initialise isp and mutex for csiphy1
n 259c3fa06348d8142406796d0e7beb5753d07d31 omap3isp: Return -EPROBE_DEFER if the required regulators can't$
5034d8d8eceec96908c4659be58507177d0a462c omap3isp: Correctly set IO_OUT_SEL and VP_CLK_POL for CCP2 mode
bf54a7459801bde07e3c1bfc7840f30abc296f62 omap3isp: Parse CSI1 configuration from the device tree
n 07120f2667ea1c02d86dce1b3d46e28cb23e3a15 omap3isp: Ignore endpoints with invalid configuration
n 5151d5af4010a2aeeaff1fb05de4661f2fd6d982 omap3isp: add CSI1 support
n 7947670b57539df822cabaaf1d0e8a78fbcd1290 omap3isp: Explicitly set the number of CSI-2 lanes used in lane$
n 7f52779e72e4c14ffdffcf0cebdefde193457a82 omap3isp: Destroy CSI-2 phy mutexes in error and module removal
n dbd6d72970e87f39936bc036a1a9441e59177434 omap3isp: Check for valid port in endpoints
n 8a61b9bf1134d7f57e2bd65aeac0b553ecc7301e smiapp: add CCP2 support
n f71d8a1c3f33b510b379278ea171d3495ac98bb6 v4l: Add support for CSI-1 and CCP2 busses
n 1d2e2bc5f4bf78db9aa63e68dfd44823f9b62237 v4l: fwnode: Obtain data bus type from FW
n 3e4351a7e39775ef13c51950f83c51fb5d98b33c v4l: fwnode: Call CSI2 bus csi2, not csi
n 5e8535c064363713855d975f2c9777bbc739c877 dt: bindings: Add strobe property for CCP2
n 3c736565c543ec97f54f177df295ed729e80d39f dt: bindings: Explicitly specify bus type


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/a58ecdeb/attachment.sig>
