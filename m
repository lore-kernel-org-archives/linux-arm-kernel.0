From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 19 Aug 2016 13:55:10 -0700
Subject: [PATCH] ARM: dts: keystone-k2g: Add Message Manager node
In-Reply-To: <20160819204748.21529-1-nm@ti.com>
References: <20160819204748.21529-1-nm@ti.com>
Message-ID: <e39f772a-8a30-4c69-fdd9-8b8a639207a6@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/19/2016 1:47 PM, Nishanth Menon wrote:
> Introduce the message manager node for the A15 queues on which Linux
> runs. The Message Manager is primarily used for communication with
> Power Management controller on K2G.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> based on: v4.8-rc1
> Bootlog: http://pastebin.ubuntu.com/23071446/ (with CONFIG_MAILBOX,
>    CONFIG_TI_MESSAGE_MANAGER enabled on top of keystone_defconfig)
> Binding: Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> SoC Datasheet and relevant documentation: http://www.ti.com/product/66ak2g02
> Communication Protocol: http://processors.wiki.ti.com/index.php/TISCI
>
Patch looks good Nishant. Do you want to send a patch to update
the config to enable TI_MESSAGE_MANAGER and MAILBOX ? Are we missing
anything upstream yet to enable these ?
