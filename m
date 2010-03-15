From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 15 Mar 2010 08:22:30 -0500
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <20100315131540.GD700@n2100.arm.linux.org.uk>
References: <4B9DB823.1040809@st.com>	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>	<4B9DC239.90407@st.com>	<1b68c6791003142241q274b573dl3e60bf25be462e68@mail.gmail.com>	<4B9DD46E.7060704@st.com>
	<20100315131540.GD700@n2100.arm.linux.org.uk>
Message-ID: <4B9E3496.3090309@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
>
> Most normal boards dedicate the function of pins at board design time;
>   

Agreed.

As I see it, the IRQF_SHARED thing is just a convenience hack for PC
motherboards, and for platform authors who haven't gotten around to
demultiplexing all their shared interrupts. :)


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
