From: artem.savkov@gmail.com (Artem Savkov)
Date: Tue,  6 Feb 2018 22:20:20 +0100
Subject: [PATCH 0/2] sun4i_ss_prng fixes
Message-ID: <20180206212022.1309-1-artem.savkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IPSec hasn't been working on my a10 board since 4.14 and it turned out to be
caused by sun4i_ss_rng driver.

Artem Savkov (2):
  sun4i_ss_prng: fix return value of sun4i_ss_prng_generate
  sun4i_ss_prng: convert lock to _bh in sun4i_ss_prng_generate

 drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.15.1
