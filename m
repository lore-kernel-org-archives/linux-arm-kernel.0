From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 14 Sep 2009 07:43:45 -0500
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1252930881.16853.99.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>	<20090821155011.GB8583@shareable.org>	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>	<1250890146.29685.18.camel@david-laptop>	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>	<1251134043.31975.23.camel@david-laptop>	<1251135709.28977.40.camel@pc1117.cambridge.arm.com>	<20090914014353.GA4762@shareable.org>	<20090914100056.GC16644@n2100.arm.linux.org.uk>	<1252922773.16853.62.camel@pc1117.cambridge.arm.com>	<1252928832.16853.96.camel@pc1117.cambridge.arm.com>
	<1252930881.16853.99.camel@pc1117.cambridge.arm.com>
Message-ID: <4AAE3A81.5010101@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> And here's an untested patch to clear the exclusive monitor on the
> exception return path. If you are OK with the idea, I'll do some testing
> before pushing it for upstream:
>   

How are you going to "test" for this one? It's such a corner case, it's 
going to be tricky to validate that your changes are actually getting 
test coverage methinks...


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
