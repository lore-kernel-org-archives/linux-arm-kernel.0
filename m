From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Jan 2013 12:39:32 -0800
Subject: [PATCH 0/6] highbank fixes for 3.8
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130102203932.GA7293@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 30, 2012 at 10:15:01AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series fixes secondary boot/hotplug, some boot warnings and
> suspend/resume for highbank. Arguably, suspend fixes are 3.9 material,
> but I'm including it here as the same fix needed for suspend/resume is
> needed to fix secondary core boot on 3.8.
> 
> Also, the Nico's gic change (ARM: gic: use a private mapping for CPU target
> interfaces) breaks QEMU which does not initialize the cpu target registers
> correctly.
> 
> Rob
> 
> Rob Herring (6):
>   ARM: dts: add device_type prop to cpu nodes on Calxeda platforms
>   ARM: dts: fix highbank cpu mpidr values
>   ARM: highbank: fix typos with hignbank in power request functions
>   ARM: highbank: fix secondary boot and hotplug
>   ARM: highbank: add a power request clear
>   ARM: highbank: save and restore L2 cache and GIC on suspend

All applied to arm-soc fixes. Thanks!


-Olof
