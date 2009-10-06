From: ananaza@iki.fi (Antti P Miettinen)
Date: Tue, 06 Oct 2009 09:12:55 +0300
Subject: smsc911x.c driver and SMP
References: <4A7AEEB6.5060903@googlemail.com>
	<1249981883.27150.14.camel@pc1117.cambridge.arm.com>
	<4A818CBC.8040000@googlemail.com>
	<1250006770.30628.1.camel@pc1117.cambridge.arm.com>
	<4A819C54.3080606@googlemail.com>
	<1250009043.30628.9.camel@pc1117.cambridge.arm.com>
	<87ab25vazg.fsf@brigitte.kvy.fi>
	<1250080338.20332.32.camel@pc1117.cambridge.arm.com>
	<87k518yc8a.fsf@brigitte.kvy.fi>
	<1252660898.3354.16.camel@pc1117.cambridge.arm.com>
	<4AAA48CA.9040405@billgatliff.com>
	<1252674034.29620.30.camel@pc1117.cambridge.arm.com>
	<4AAA6AB7.60808@billgatliff.com>
	<1252685189.29620.33.camel@pc1117.cambridge.arm.com>
Message-ID: <87my459hjs.fsf@brigitte.kvy.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:
> Fixed it with this new commit (I'm not posting the patch here as it's
> not meant for review on this list):
>
> http://www.linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=3cc8ee538f6727d1f6773fff6d8e31bc5522bfee

Just a piece of information: with vanilla 2.6.31 boot from NFS root on
my PB11MPCore hangs, with this patch applied, boot succeeds.

-- 
http://www.iki.fi/~ananaza/
