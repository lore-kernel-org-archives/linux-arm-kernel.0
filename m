From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 10 Aug 2018 10:53:31 +0200
Subject: [PATCH v2 4/7] watchdog: Add support for Armada 37xx CPU watchdog
In-Reply-To: <20180809022037.12001-5-marek.behun@nic.cz>
References: <20180809022037.12001-1-marek.behun@nic.cz>
 <20180809022037.12001-5-marek.behun@nic.cz>
Message-ID: <20180810105331.446563b4@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Beh?n <marek.behun@nic.cz> wrote on Thu,  9 Aug 2018 04:20:34
+0200:

> This adds support for the CPU watchdog found on Marvell Armada 37xx
> SoCs.
> 
> There are 4 counters which can be set as CPU watchdog counters.
> This driver uses the second counter (ID 1, counting from 0)
> (Marvell's Linux also uses second counter by default).
> In the future it could be adapted to use other counters, with
> definition in the device tree.
> 
> Signed-off-by: Marek Behun <marek.behun@nic.cz>
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

(on an EspressoBin)

Thanks,
Miqu?l
