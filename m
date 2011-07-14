From: khilman@ti.com (Kevin Hilman)
Date: Thu, 14 Jul 2011 14:58:10 -0700
Subject: [PATCH 1/2] TI816X: Add minimal hwmod data
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
References: <1303922002-6946-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1104281634050.11487@utopia.booyaka.com>
	<5F744A5A3C131242B81CE5874BD2CFFBBF8F8F14@dlee01.ent.ti.com>
	<alpine.DEB.2.00.1104282058370.11487@utopia.booyaka.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03AB5FAAAB@dbde02.ent.ti.com>
Message-ID: <1310680690.8322.41.camel@vence>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hemant,

On Wed, 2011-07-13 at 05:07 +0530, Pedanekar, Hemant wrote:

> Any comments on the hwmod and clock patch sets?

I just discovered that other devices in this family are coming along
which will require changing the names/macros/etc. from 816x to 81xx[1].

Merging this series, followed shortly by another series that renames
everything is the type of churn we are trying to avoid.

To avoid this kind of churn, I recommend starting from the broader
family name first.

Kevin

http://arago-project.org/git/projects/?p=linux-omap3.git;a=commit;h=ce17fa2f527ed614399e577fc2fd5cd3624ee501
