From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Mon, 29 Aug 2016 20:03:20 +0200
Subject: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160829180321.11695-1-dannym@scratchpost.org>
References: <20160829180321.11695-1-dannym@scratchpost.org>
Message-ID: <20160829180321.11695-2-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This distinguishes sun4i from sun7i. It is necessary because they use
different registers for the audio mixer.
---
 sound/soc/sunxi/sun4i-codec.c | 44 +++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ASoC-sun4i-codec-Distinguish-sun4i-from-sun7i.patch
Type: text/x-patch
Size: 3488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/6c2b94d6/attachment.bin>
