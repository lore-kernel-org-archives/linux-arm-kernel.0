From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 28 Oct 2014 12:01:38 +0100
Subject: [PATCHv2 0/6] net: fec: fix regression on i.MX28 introduced by
 rx_copybreak support
Message-ID: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes wrt. v1:
- added some cleanup patches
- simplify handling of 'quirks' flags as suggested by Russell King.
- remove DIV_ROUND_UP() from byte swapping loop as suggested by
  Eric Dumazet

Subject: 
In-Reply-To: 
