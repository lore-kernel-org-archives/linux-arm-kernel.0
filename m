From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 29 Mar 2016 07:21:04 +0200
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
 (Tim Harvey's message of "Mon, 28 Mar 2016 13:42:33 -0700")
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
 <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
 <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
Message-ID: <m3a8lhkgfz.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tim Harvey <tharvey@gateworks.com> writes:

> ok - I'll respond there as I agree with the patch but not the wording
> of the commit (It's Gateworks 'Ventana' using IMX6 not Laguna and we
> do define the polarity properly as active-low in Ventana dt's).

Right, it's Ventana of course (I had been working with Laguna boards
recently).

> However, there seems to be another regression in 4.5 that's keeping
> PCI working for me and I'm still bisecting that (using 802.11n access
> points to test). Can you confirm that PCI works in v4.5 on IMX6 boards
> with only 5c5fb40de8f14391a1238db05cef88754faf9229 reverted?

I will check with my frame buffer and wifi cards.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
