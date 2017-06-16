From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Jun 2017 01:35:24 -0700
Subject: [PATCH 1/3] ARM: Generalize fncpy implementation
In-Reply-To: <577f22f3-ff16-05a0-8204-39e86d47dd9f@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
 <20170615232117.29727-2-f.fainelli@gmail.com>
 <577f22f3-ff16-05a0-8204-39e86d47dd9f@gmail.com>
Message-ID: <20170616083524.GJ3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Fainelli <f.fainelli@gmail.com> [170615 16:27]:
> On 06/15/2017 04:21 PM, Florian Fainelli wrote:
> > ARM's fncpy implementation is actually suitable for a large number of
> > platforms since the only assumption it makes is just the function's
> > alignment (8 bytes) which also happens to fulfil other architectures,
> > including but not limited to ARM64.

Yeah I'm all for it. Maybe mention in the next version that this helps
with making SoC specific PM code into just regular Linux device drivers.

Regards,

Tony
