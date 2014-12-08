From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 12:22:20 +0100
Subject: [PATCH v2 1/5] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <1418006316-324-2-git-send-email-rjui@broadcom.com>
References: <1418006316-324-2-git-send-email-rjui@broadcom.com>
Message-ID: <2594176.SCRFa6Sb3O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 December 2014 18:38:32 Ray Jui wrote:
> +Required properties:
> +
> +- compatible:
> +    Currently supported Cygnus GPIO controllers include:
> +    "brcm,cygnus-ccm-gpio": ChipcommonG GPIO controller
> +    "brcm,cygnus-asiu-gpio": ASIU GPIO controller
> +    "brcm,cygnus-crmu-gpio": CRMU GPIO controller

How different are these? If they are almost the same, would it
be better to use the same compatible string for all of them and
describe the differences in extra properties?

If they are rather different, maybe you should have a separate
binding and driver for each?

	Arnd
