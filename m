From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Jun 2012 11:00:35 -0600
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
References: <4FD85127.8050301@firmworks.com>
 <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
 <4FDA2DDA.1030704@wwwdotorg.org>
 <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
Message-ID: <4FE4A4B3.9010200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2012 05:00 AM, Thierry Reding wrote:
...
> Stephen: can you try to find out whether the Tegra PCIe controller 
> indeed implements ECAM, or if this scheme is actually just a
> proprietary variant?

Sure. I have added this request to the bug I filed requesting more
complete PCIe host documentation.
