From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 10:43:04 +0000
Subject: [PATCH 1/6 v12] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <AANLkTintT+dnpKvosuzS6aMV0dw0+2rBw2=S53-D-atp@mail.gmail.com>
References: <4D110269.9030805@bluewatersys.com>
	<20101222211815.GA31054@alchark-u3s>
	<4D12730B.2030909@bluewatersys.com>
	<20101222222501.GA32693@alchark-u3s>
	<4D1282DA.4020804@bluewatersys.com>
	<20101222233821.GA20893@alchark-u3s>
	<AANLkTik1tcL_ABdnq5r=MCxmLJtdP0nhOzA8irP1n0CC@mail.gmail.com>
	<AANLkTinb3A5CJ6r4Y0D0kMwJn8ZEyf_0mb4uW99mmUZ9@mail.gmail.com>
	<20110115005818.GV15996@n2100.arm.linux.org.uk>
	<AANLkTintT+dnpKvosuzS6aMV0dw0+2rBw2=S53-D-atp@mail.gmail.com>
Message-ID: <20110121104304.GJ13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 04:13:48AM +0300, Alexey Charkov wrote:
> Ok, life is life. Could you then please take these to your tree for .39?

Taken.  However, Lennert has been converting ARM to use the new irq_*
irq_chip methods, which your code has missed out on.  Any chance of a
follow-up patch to switch it over?
