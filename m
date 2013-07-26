From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Fri, 26 Jul 2013 16:59:19 -0400 (EDT)
Subject: [RFC] ARM: davinci: da850: add a few pinmux definitions
In-Reply-To: <51F0F377.1060204@ti.com>
Message-ID: <55770703.973667.1374872359591.JavaMail.root@mail>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

You wrote:
> Why do you need to add these definitions? If it is for a new platform
> you are working on, then it should be supported using DT, in which
> case
> we use the pinctrl-single driver and define the muxing needed in
> .dts/.dtsi files.

Ok, good to know.

Thanks,
Vivien
