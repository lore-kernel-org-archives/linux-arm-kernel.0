From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:22:06 -0700
Subject: [PATCH] ARM: dts: dra72-evm: Rename 3.3V regulator tag
In-Reply-To: <1464120040-28776-1-git-send-email-misael.lopez@ti.com>
References: <1464120040-28776-1-git-send-email-misael.lopez@ti.com>
Message-ID: <20160610112206.GA22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Misael Lopez Cruz <misael.lopez@ti.com> [160524 13:02]:
> Rename the tag of the 3.3 V regulator used in the DRA72 EVM in
> order to have a consistent tag name with the DRA7 EVM.  This
> is useful when the regulator needs to be referenced in common
> dtsi files (i.e. for common companion boards like JAMR3 [1]).

Applying into omap-for-v4.8/dt thanks.

Tony
