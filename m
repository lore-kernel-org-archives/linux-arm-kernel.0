From: davem@davemloft.net (David Miller)
Date: Wed, 21 Sep 2011 01:21:58 -0400 (EDT)
Subject: [PATCH 0/3] GIC OF bindings
In-Reply-To: <4E796EE4.6070704@firmworks.com>
References: <20110920.224910.1996429830782124690.davem@davemloft.net>
	<CACxGe6t7Mdr+w+aGFPM2-FEAQaYHuG8Za9dybLgMo-5-whLyNQ@mail.gmail.com>
	<4E796EE4.6070704@firmworks.com>
Message-ID: <20110921.012158.2252182592946972727.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mitch Bradley <wmb@firmworks.com>
Date: Tue, 20 Sep 2011 18:58:12 -1000

> interrupt-parent has been part of the interrupt mapping spec from the
> inception of same.
> 
> http://www.openfirmware.info/docs/rec.intmap.d09.pdf

Thanks for the link.

In my vast collection of Sun OF dumps, I cannot find a single instance
where they've made use of this property, which is why I've never seen
it before.
