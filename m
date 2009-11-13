From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 13 Nov 2009 08:00:27 -0600
Subject: ARM: big performance waste in memcpy_{from,to}io
In-Reply-To: <20091113122438.GB29008@n2100.arm.linux.org.uk>
References: <200911121749.49676.h.feurstein@gmail.com>	<ol1us6-035.ln1@chipmunk.wormnet.eu>	<200911131232.41716.h.feurstein@gmail.com>
	<20091113122438.GB29008@n2100.arm.linux.org.uk>
Message-ID: <4AFD667B.3020505@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> The problem is whether optimising it will end up breaking existing users.
>   

I say we throw in the optimized version and enable it by default, along
with a Kconfig to defeat it upon user request at build time (or maybe a
module parameter).  And then see who complains.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
