From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 05 Jul 2010 14:29:35 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA42DA3944FD5@GEORGE.Emea.Arm.com>
References: <20100702180257.GA8767@pengutronix.de>
	<F01D8B85CFF58440B2A13965FBA90CA42DA3944FD5@GEORGE.Emea.Arm.com>
Message-ID: <4C31D02F.7030608@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Tuckley wrote:
>> -----Original Message-----
>> kernel-bounces at lists.infradead.org] On Behalf Of Robert Schwebel
>> Sent: 02 July 2010 19:03
> 
>> We have recently made some benchmarks, in order to get a little bit
>> better fealing about where ARM cpus are today, especially when it comes
>> to the "recent" ones, and in comparism to the Atom. So we collected a
>> few benchmarks (most from lmbench) and did some actual measurements.
> 
> You have the family wrong for (at least) the Cortex-A8, it's a v7. This probably accounts for some of it's slow relative performance since you probably used incorrect compiler switches.
> 
>> All measurements have been done on 2.6.34.
> 
> How were the kernels compiled? Was thumb mode used for the ones that support it?

gcc version 4.3.2 was for all kernels. The kernel .config will be added
to the website.

> You didn't mention the cache state anywhere - it can make a big difference.

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100705/811861cb/attachment.sig>
