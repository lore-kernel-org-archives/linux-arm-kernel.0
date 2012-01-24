From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jan 2012 12:12:46 +0200
Subject: [PATCH 3/3] S3C2443: add power domain for usb phy
In-Reply-To: <201201241109.48749.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
 <201201241050.14405.heiko@sntech.de>
 <20120124095130.GA27414@legolas.emea.dhcp.ti.com>
 <201201241109.48749.heiko@sntech.de>
Message-ID: <20120124101245.GG27414@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 11:09:48AM +0100, Heiko St?bner wrote:
> Am Dienstag, 24. Januar 2012, 10:51:31 schrieb Felipe Balbi:
> > On Tue, Jan 24, 2012 at 10:50:14AM +0100, Heiko St?bner wrote:
> > > Hi Felipe,
> > > 
> > > Am Dienstag, 24. Januar 2012, 10:38:32 schrieb Felipe Balbi:
> > > > Hi,
> > > > 
> > > > On Sun, Jan 08, 2012 at 09:59:02PM +0100, Heiko St?bner wrote:
> > > > > The phy-power-handling is common to S3C2443/2416/2450, so introduce a
> > > > > s3c2443-pm-common.c to handle this for all of them.
> > > > > 
> > > > > This makes it possible to remove the raw write to the PWRCFG-register
> > > > > from the s3c-hsudc driver.
> > > > > 
> > > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > 
> > > > I believe this doesn't really depend on previous patches (??) In that
> > > 
> > > > case, it can be carried with s3c's tree:
> > > it does depend on the previous patch [2/3], as the device power domain is
> > > controlled through the runtime-pm subsystem whose calls were added in it.
> > 
> > then I will need proper acks to carry this patch.
> 
> ok, I will pester Kukjin Kim more about it to get the needed ack :-) .
> 
> If changes are requested to this third patch should I only resubmit this one 
> or all of them again - i.e. will you still keep the first two patches?

first two are already applied so no need to resend them :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/ca419423/attachment.sig>
