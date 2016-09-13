From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 13 Sep 2016 09:00:04 +0200
Subject: [PATCH net-next 0/2] mvneta xmit_more and bql support
Message-ID: <1473750006-21199-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short patchset introduces two enhancements to mvneta driver
TX packets concatenation support using xmit_more mechanism and also
byte queue limit in order to decrease latency on saturated links.

Any comments or feedback would be welcome.

Best regards,
Marcin

Marcin Wojtas (1):
  net: mvneta: add BQL support

Simon Guinot (1):
  net: mvneta: add xmit_more support

 drivers/net/ethernet/marvell/mvneta.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

-- 
1.8.3.1
