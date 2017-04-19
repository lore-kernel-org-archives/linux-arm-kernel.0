From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 19 Apr 2017 13:28:04 -0700
Subject: [PATCH] soc: bcm: brcmstb: Correctly match 7435 SoC
In-Reply-To: <20170419170136.4979-1-f.fainelli@gmail.com>
References: <20170419170136.4979-1-f.fainelli@gmail.com>
Message-ID: <CADtm3G5yJhM8cfqS_xbp2TjWxsB_ipfsL5oFoMq_1SH-mW3rHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 10:01 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Remove the duplicate brcm,bcm7425-sun-top-ctrl compatible string and
> replace it with brcm,bcm7435-sun-top-ctrl which was intentend.

s/intentend/intended/

>
> Fixes: bd0faf08dc7f ("soc: bcm: brcmstb: Match additional compatible strings")
> Reported-by: Andreas Oberritter <obi@saftware.de>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
