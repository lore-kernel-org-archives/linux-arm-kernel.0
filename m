From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Mon, 5 Jul 2010 09:51:35 +0100
Subject: Some benchmarks on ARM
In-Reply-To: <20100702180257.GA8767@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA42DA3944FD5@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> kernel-bounces at lists.infradead.org] On Behalf Of Robert Schwebel
> Sent: 02 July 2010 19:03

> We have recently made some benchmarks, in order to get a little bit
> better fealing about where ARM cpus are today, especially when it comes
> to the "recent" ones, and in comparism to the Atom. So we collected a
> few benchmarks (most from lmbench) and did some actual measurements.

You have the family wrong for (at least) the Cortex-A8, it's a v7. This probably accounts for some of it's slow relative performance since you probably used incorrect compiler switches.

> All measurements have been done on 2.6.34.

How were the kernels compiled? Was thumb mode used for the ones that support it?

You didn't mention the cache state anywhere - it can make a big difference.

Regards,

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
