From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jul 2010 09:49:43 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <AANLkTim55BDz4_vWhTnDVj1EP42MxAMZzP2PR80j5fLN@mail.gmail.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092658.GB29885@csn.ul.ie>
	<20100713093815.GD20590@n2100.arm.linux.org.uk>
	<20100713095035.GE29885@csn.ul.ie>
	<20100713173744.GB30142@n2100.arm.linux.org.uk>
	<20100713203250.GA21600@csn.ul.ie>
	<AANLkTim55BDz4_vWhTnDVj1EP42MxAMZzP2PR80j5fLN@mail.gmail.com>
Message-ID: <20100714084943.GA9115@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 08:59:06AM +0900, Minchan Kim wrote:
> But I think Kukjin case's best solution is to make section size 16M, not 256M.
> Regardless of this, Your idea is the direction we should proceed, I think.

So what if someone decides to fit 8MB DRAMs to the board?
