From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2011 16:29:51 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <BANLkTimz8zprEw7H_i8g2qj8RyyougiBBw@mail.gmail.com>
References: <201104212129.17013.arnd@arndb.de>
	<BANLkTim5umALqafjA2e88UCLzMp9LQu3_Q@mail.gmail.com>
	<BANLkTimz8zprEw7H_i8g2qj8RyyougiBBw@mail.gmail.com>
Message-ID: <201104261629.51765.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 April 2011, KyongHo Cho wrote:
> IOMMU api does not provide virtual memory management.
> DMA api is not flexible for all our use-cases.

We can fix either problem by changing the existing interfaces,
which is much more maintainable in the long run than adding
a third one.

	Arnd
