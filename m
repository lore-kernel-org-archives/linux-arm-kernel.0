From: akurz@blala.de (Alexander Kurz)
Date: Sat, 26 May 2018 18:30:50 +0000
Subject: ARM: dts: imx6: enable OTG on wandboard and riotboard 
Message-ID: <20180526183053.14029-1-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both boards wandboard and riotboard feature an USB OTG connector.
Change the DT regulator nodes to match the convention, fix the
GPIO regulator polatity for the riotboard and add enable OTG
including the regulator infrastructure on the riotboard. 
