From: ayaka@soulik.info (Randy Li)
Date: Sun, 18 Sep 2016 22:09:10 +0800
Subject: [PATCH] make samsung interface entries explicitly
Message-ID: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found those modules should be selected directly, as I
only use the simple sound card.

Randy Li (1):
  ASoC: samsung: make audio interface/controller explicitly

 sound/soc/samsung/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4
