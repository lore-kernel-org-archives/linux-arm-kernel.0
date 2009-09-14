From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 14 Sep 2009 14:30:51 -0500
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252933052.16853.114.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>	
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>	
	<20090821155011.GB8583@shareable.org>	
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>	
	<1250890146.29685.18.camel@david-laptop>	
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>	
	<1251134043.31975.23.camel@david-laptop>	
	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>	
	<20090914014353.GA4762@shareable.org>	
	<20090914100056.GC16644@n2100.arm.linux.org.uk>	
	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>	
	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>	
	<1252930881.16853.99.camel@pc1117.cambridge.arm.com>	
	<4AAE3A81.5010101@billgatliff.com>
	<1252933052.16853.114.camel@pc1117.cambridge.arm.com>
Message-ID: <4AAE99EB.4060805@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> Apart from the switch_to and atomic_set modifications, the patch cannot
> do more harm. As for these functions, I don't see any reason why the
> modifications would not be correct but we can delay the merging until we
> are sure (anyway, the more people looking at the patch, the better).
>   

Clearly, you understand the fundamentals behind my question--- and you 
have a pretty satisfactory answer as well.

That's all I was after, really.  Carry on.  :)


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
