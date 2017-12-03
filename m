From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Dec 2017 19:01:04 -0200
Subject: [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
In-Reply-To: <5ec7ae30-eeac-3cf8-15ad-f6c3a110c5d7@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
 <20171201224425.5477-2-peda@axentia.se>
 <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
 <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se>
 <CAOMZO5AE++an6MnagrWoL4qwkDJaqtg_qJ5UKX3PB7sw1cTeiA@mail.gmail.com>
 <5ec7ae30-eeac-3cf8-15ad-f6c3a110c5d7@axentia.se>
Message-ID: <CAOMZO5Dgr6B19o+1xQJ7Ne8SC7kx90_iecHjD7tZ-GCsSr3JXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 3, 2017 at 6:53 PM, Peter Rosin <peda@axentia.se> wrote:

> That's funny, because I get the below on both 4.14 and 4.15-rc1. And I
> expect the same ever since the driver was added some 3 years ago.
>
> $ scripts/get_maintainer.pl your-patch-from[1].diff | grep Peter
> Peter Rosin <peda@axentia.se> (maintainer:NXP TFA9879 DRIVER)

You are right.

I tried ./scripts/get_maintainer.pl
Documentation/devicetree/bindings/sound/tfa9879.txt

in 4.15-rc1.
