From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 18:15:10 +0100
Subject: [PATCH v3 5/7] ARM: brcmstb: add misc. DT bindings for brcm,
 brcmstb-*
In-Reply-To: <20140115171155.GK25824@e106331-lin.cambridge.arm.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <1389743333-16741-6-git-send-email-marc.ceeeee@gmail.com>
 <20140115171155.GK25824@e106331-lin.cambridge.arm.com>
Message-ID: <12927046.KPmoBiUFty@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 17:11:55 Mark Rutland wrote:
> > +
> > +Further, a node with the following compatible string shall be defined:
> > +
> > +    - compatible: "brcm,brcmstb-gen-ctrl-v1"
> 
> It's probably better to say a brcmstb-gen-ctrl node (described below)
> should be present, or you'll have two places to update the compatible
> strings for each new variant...

See my other reply on this node. The previous patch version had a different
approach to these registers, and I suggested doing yet another one and
using syscon.

	Arnd
