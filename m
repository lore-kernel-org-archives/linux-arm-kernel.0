From: abdun.nihaal@gmail.com (Abdun Nihaal)
Date: Sun,  3 Jun 2018 21:29:57 +0530
Subject: [PATCH 0/7] staging: mt7621-pci: Fix coding style issues
Message-ID: <cover.1528040188.git.abdun.nihaal@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes the following set of coding style 
issues found using checkpatch.

ERROR: space prohibited after that open parenthesis '('
ERROR: trailing whitespace
ERROR: space required before the open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: spaces required around that '==' (ctx:WxV)
ERROR: that open brace { should be on the previous line

Abdun Nihaal (7):
  staging: mt7621-pci: Remove space after open parenthesis
  staging: mt7621-pci: remove trailing whitespace
  staging: mt7621-pci: add space before open parenthesis
  staging: mt7621-pci: add space after comma symbol
  staging: mt7621-pci: add spaces around equal symbol
  staging: mt7621-pci: add space after '==' symbol
  staging: mt7621-pci: fix coding style error

 drivers/staging/mt7621-pci/pci-mt7621.c | 114 ++++++++++++------------
 1 file changed, 56 insertions(+), 58 deletions(-)

-- 
2.17.0
