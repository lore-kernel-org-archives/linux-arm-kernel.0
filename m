From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jul 2014 22:11:14 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140730132348.GM29590@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730110425.GI12239@arm.com> <20140730132348.GM29590@ulmo>
Message-ID: <201407302211.14342.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 July 2014, Thierry Reding wrote:
se?
> 
> I think there weren't any comments left for me to address and I've
> mostly been waiting for Joerg to pick it up.
> 
> Joerg, can you take this through the iommu tree for 3.17? Will acked
> this, but perhaps you were waiting for an ACK from the device tree
> bindings maintainers?
> 
> Will, perhaps you can get Pawel or Mark to look at this?
> 
> Arnd, I'm sure if we had your Acked-by that would go a long way too.


Sorry for missing this before my vacation.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Olof, please merge it into arm-soc so we can finally build on top
of this!

	Arnd
