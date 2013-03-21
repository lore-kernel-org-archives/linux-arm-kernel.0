From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Mar 2013 14:36:23 +0100
Subject: [PATCH 00/16] Marvell EBU thermal sensor consolidation
In-Reply-To: <20130321123556.GC22714@localhost>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321064501.GK21478@lunn.ch> <20130321123556.GC22714@localhost>
Message-ID: <20130321133623.GB5627@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why do you think it has two sensors?

The register set i've seen talks of a junction temperate and a
"thermal manager current temperature". The thermal manager temperature
went up as i loaded the CPU and dropped down again as it was idle and
cooled. I've no idea if these are two different sensors, or one is an
averaged value of the other, etc. I would hope the datasheet gives a
description.....

     Andrew
