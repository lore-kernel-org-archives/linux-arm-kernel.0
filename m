From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Jul 2012 16:23:20 +0100
Subject: Device tree binding for DVFS table
In-Reply-To: <4FFE4FE6.20109@nvidia.com>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk> <4FFE4FE6.20109@nvidia.com>
Message-ID: <20120712152320.GA7256@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 09:47:42AM +0530, Prashant Gaikwad wrote:
> On Wednesday 11 July 2012 08:14 PM, Mark Brown wrote:

> >I'd also expect to see a range of voltages for each frequency rather
> >than a specific voltage; usually things are at least characterised with
> >a specified tolerance.

> But then how will you determine the operating voltage for a frequency?

By passing the range into the regulator API - the regulator API always
takes a voltage range anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/cf8d306e/attachment.sig>
