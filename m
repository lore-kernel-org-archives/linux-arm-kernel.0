From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 28 Jun 2018 04:21:30 +0800
Subject: [PATCH v2 0/7] Allwinner A64 DE2 CCU support with dedicated DE2
 bus driver
In-Reply-To: <20180627183721.jmmsmp3u3mq4drvb@flea>
References: <20180622122615.55836-1-icenowy@aosc.io>
 <20180627183721.jmmsmp3u3mq4drvb@flea>
Message-ID: <EB513C5E-4BBD-46B2-9B61-18ED0B14C0E4@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?6?28? GMT+08:00 ??2:37:21, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Fri, Jun 22, 2018 at 08:26:08PM +0800, Icenowy Zheng wrote:
>> This patchset tries to implement the Allwinner A64 DE2 as a bus
>driver,
>> in order to model the fact that the SRAM claim controls the access to
>> the whole DE2 memory space.
>> 
>> PATCH 1 and PATCH 4 are for the CCU part.
>> 
>> PATCH 2 is the device tree binding for the A64 DE2 bus, and PATCH 3
>> implements the bus driver.
>> 
>> PATCH 5 adds the DE2 CCU device tree node, with the DE2 bus node.
>> 
>> PATCH 6 and 7 are HDMI simplefb patches for A64. They're present as a
>> test to this patchset.
>
>Applied all the patches with the minor modifications Chen-Yu and I
>suggested.
>
>The threading was broken on your serie though, so you probably want to
>check your git configuration.

In fact I think I should check my ISP configuration.

The breakage is introduced due to too long delay between aosc.io
mail server and my computer, so I must start to send the
remaining patches again.

>
>Thanks!
>Maxime
