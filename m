From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 14 Dec 2017 19:36:42 +0100
Subject: DT dtc warnings
In-Reply-To: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
Message-ID: <20171214183642.GF2559@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 14/12/2017 at 12:21:06 -0600, Rob Herring wrote:
> Hi all,
> 
> Below is a current list of ARM boards with more than 40 dtc warnings
> when building with W=1. There's a treewide patch in flight to fix some
> unit-address warnings[1], so those aren't included here. The list is
> grouped by maintainer. AT91, Exynos, and Allwinner continue to be at
> the top of the list and have been for some time (though having
> multiple boards for an SoC can cause lots of duplicated warnings).
> 
> Please help fix these. More checks are being added[2].
> 

For the at91 ones, IIRC, they are coming from the clock binding and we
will have to break the ABI to fix it. This is not something we wanted to
do before 4.14 but it will happen at some point.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
