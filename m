From: akurz@blala.de (Alexander Kurz)
Date: Tue, 29 May 2018 06:20:17 +0000
Subject: enable OTG on wandboard and riotboard 
Message-ID: <20180529062021.3154-1-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both boards wandboard and riotboard feature an USB OTG connector.
Change the DT regulator nodes to match the convention, fix the
GPIO regulator polatity for the riotboard and add enable OTG
including the regulator infrastructure on the riotboard. 

Changes since v2:
* split patch 0001 into two board specific patches
* use GPIO_ACTIVE_HIGH instead of literal numbers in patch v1-0001 (now v2-0002) 
