From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 09 Jan 2013 19:49:40 +0100
Subject: [PATCH V2 0/4] add RTC support for Armada 370 and Armada XP
In-Reply-To: <50C849E8.70105@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
 <50C849E8.70105@free-electrons.com>
Message-ID: <6174336.QCHWFhIiR1@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012 10:10:00 Gregory CLEMENT wrote:
> On 12/12/2012 10:06 AM, Gregory CLEMENT wrote:
> > Hello,
> > 
> > This small patch set adds RTC support for Armada 370 and Armada XP. It
> > was successfully tested on the evaluation board. The third patch add
> > the lacking documentation for the device tree binding and was already
> > taken by Grant Likely, I keep this one in the series for
> > coherency. The only differences with the previous patch set was the
> > add of the Acked-by from Andrew Lunn and a new small patch to update
> > of the mvebu_configuration. I also split the patch wich add the RTC
> > support in two part, one for the RTC subsytem and on for
> > mach-mvebu. This series is 3.9 material.

Tested-by: Florian Fainelli <florian@openwrt.org>

on RD-A370-A1
-- 
Florian
