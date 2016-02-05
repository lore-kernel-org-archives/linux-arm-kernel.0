From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 5 Feb 2016 13:45:11 +0100
Subject: [PATCH 0/2] crypto: atmel-sha - fix resource management
Message-ID: <cover.1454675769.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

these two small patches fix resource release and clock management in
atomic context.

Best regards,

Cyrille

Cyrille Pitchen (2):
  crypto: atmel-sha: fix atmel_sha_remove()
  crypto: atmel-sha - remove calls of clk_prepare() from atomic contexts

 drivers/crypto/atmel-sha.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
1.8.2.2
