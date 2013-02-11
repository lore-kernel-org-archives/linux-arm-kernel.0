From: arnd@linaro.org (Arnd Bergmann)
Date: Mon, 11 Feb 2013 15:12:32 +0000
Subject: [PATCH V2] usb: ehci: more bus glues as separate modules
In-Reply-To: <5118e529.4439440a.3347.ffffdc7d@mx.google.com>
References: <y> <5118e529.4439440a.3347.ffffdc7d@mx.google.com>
Message-ID: <201302111512.32900.arnd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 February 2013, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the SOC On-Chip host controller driver from ehci-hcd
> host code into its own driver module

Hi Manjunath,

Please include in your next version of this a more verbose
description of why this is all done, as  Ezequiel Garcia
suggested. It would also be helpful to have a list of the
changes from the previous version here.

	Arnd
