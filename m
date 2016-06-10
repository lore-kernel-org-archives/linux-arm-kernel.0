From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:38:37 -0700
Subject: [PATCH 23/28] ARM: dts: DRA7: Add DT node for DES IP
In-Reply-To: <1464772006-11254-4-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
 <1464772006-11254-1-git-send-email-t-kristo@ti.com>
 <1464772006-11254-4-git-send-email-t-kristo@ti.com>
Message-ID: <20160610113836.GF22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160601 02:09]:
> From: Joel Fernandes <joelf@ti.com>
> 
> DRA7xx SoCs have a DES3DES IP. Add DT data for the same.

Are these dts changes safe to apply separately or do they
cause issues like extra warnings during boot?

Regards,

Tony
