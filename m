From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Jan 2018 17:54:07 +0100
Subject: [PATCH 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20180110165147.26605-3-gregory.clement@free-electrons.com>
References: <20180110165147.26605-1-gregory.clement@free-electrons.com>
 <20180110165147.26605-3-gregory.clement@free-electrons.com>
Message-ID: <20180110175407.2185e95c@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 10 Jan 2018 17:51:47 +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.

Seems like the binding documentation update is not part of this patch :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
