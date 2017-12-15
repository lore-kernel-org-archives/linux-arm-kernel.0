From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Dec 2017 08:44:08 -0800
Subject: [PATCH] ARM: dts: am43xx: Fix inverted DS0_PULL_UP_DOWN_EN macro
In-Reply-To: <20171213212443.22632-1-d-gerlach@ti.com>
References: <20171213212443.22632-1-d-gerlach@ti.com>
Message-ID: <20171215164408.GG3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [171213 13:27]:
> Due to a mistake in documentation the DS0_PULL_UP_DOWN_EN macro was
> mistakenly defined as an active high bit, however setting the bit
> actually disables the internal pull resistor on the pin, so correct this
> macro and introduce a new DS0_PULL_UP_DOWN_DIS macro with the proper bit
> value set now that the documentation has been updated.
> 
> Change based on AM437x Techninal Reference Manual SPRUHL7G Revised June
> 2017 Section 7.2.1.

Applying into omap-for-v4.16/dt thanks,

Tony
