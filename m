From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri, 26 Aug 2016 09:22:30 +0200
Subject: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In, Mic 2,
 Capture Source, Differential Line-In.
In-Reply-To: <20160826072230.30429-1-dannym@scratchpost.org>
References: <20160826072230.30429-1-dannym@scratchpost.org>
Message-ID: <20160826072230.30429-3-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Note: Mic1 Capture Volume is in a different register on A20 than on A10.
Note: Mic2 Capture Volume is in a different register on A20 than on A10.
---
 sound/soc/sunxi/sun4i-codec.c | 256 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 236 insertions(+), 20 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-Add-mixer-controls-Line-In-FM-In-Mic-2-Capture-Sourc.patch
Type: text/x-patch
Size: 14407 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160826/40d89788/attachment.bin>
