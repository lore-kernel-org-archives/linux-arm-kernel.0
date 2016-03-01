From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Mar 2016 21:00:59 +0530
Subject: [PATCH 0/3] davinci: device tree - small simplifications
In-Reply-To: <1456785206-2280-1-git-send-email-david@lechnology.com>
References: <1456785206-2280-1-git-send-email-david@lechnology.com>
Message-ID: <56D5B5B3.5040606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tuesday 01 March 2016 04:03 AM, David Lechner wrote:
> I have been trying out device tree with mach-davinci. Here are some small
> simplifications that I have made.

Thanks! I will take a look. I have already sent my pull request for v4.6
so these would now be targeted to v4.7

> I would also like to know if anyone is working on getting the clocks and related
> soc devices (pll and psc) into device tree as well.

Not to my knowledge. As you might have noticed, keystone platform has a
(very similar) psc and has a common clock framework driver for that in
mainline. The goal should be to reuse that for DaVinci.

Thanks,
Sekhar
