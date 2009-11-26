From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2009 15:51:09 +0000
Subject: IXP425: help on HSS channelized service
In-Reply-To: <200911261644.51155.schindele@nentec.de>
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<200911261543.08448.schindele@nentec.de>
	<20091126144956.GA7150@n2100.arm.linux.org.uk>
	<200911261644.51155.schindele@nentec.de>
Message-ID: <20091126155109.GA8276@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 05:44:50PM +0200, Juergen Schindele wrote:
> Thanks for your information. I can include "linux/types.h"
> where are defined these typedefs (i think its what you mean):
> 
> typedef __u16 __bitwise __le16;
> typedef __u16 __bitwise __be16;
> typedef __u32 __bitwise __le32;
> typedef __u32 __bitwise __be32;

Yes.

> but where are these ????
> typedef __u8 __bitwise __le8;
> typedef __u8 __bitwise __be8;
> 
> are they missing or am _I_ missing something ??? 

Well, thinking about it, __le8/__be8 don't make that much sense...
