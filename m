From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 24 Aug 2016 15:40:28 +0900
Subject: [PATCH 0/2] reset: uniphier: follow-up fix, clean-up
Message-ID: <1472020830-16059-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Philipp,

Here is two follow-up patches.
  - add missing static
  - use of_device_get_match_data() rather than of_match_node()
    for the probe clean-up

The initial commit of the driver is still on the top of
"reset/next" branch.

If possible, could you squash these two into the initial one?
Nobody would be bothered with this.



Masahiro Yamada (2):
  reset: uniphier: add static qualifier to probe function
  reset: uniphier: use of_device_get_match_data() to get matched data

 drivers/reset/reset-uniphier.c | 81 +++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

-- 
1.9.1
