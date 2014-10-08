From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 21:25:44 +0200
Subject: [PATCH 3/3] dt-bindings: add documentation for Mediatek SoC
In-Reply-To: <1412760987-1668-3-git-send-email-ibanezchen@gmail.com>
References: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
 <1412760987-1668-3-git-send-email-ibanezchen@gmail.com>
Message-ID: <5850563.shKyCK3zuY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 October 2014 17:36:27 Howard Chen wrote:
> This adds a DT binding documentation for the MT6592 SoC from Mediatek.
> 
> Signed-off-by: Howard Chen <ibanezchen@gmail.com>
> 

mt6592 is closely related to mt6572 and mt6582, right?

Maybe you can add all three here, at least to the documentation?
I don't know how significant the differences really are, but you
could also have an mt65x2.dtsi file that contains the common parts
and that gets included by these three, or any other variants such
as mt6582m.

	Arnd
