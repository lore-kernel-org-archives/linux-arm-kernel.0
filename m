From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Mon,  5 Sep 2016 21:24:03 +0200
Subject: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Message-ID: <20160905192404.13871-1-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's just the part that allows distinguishing sun4i from sun7i.

Since I'm waiting for Chen-Yu's DAPM_DOUBLE patch series I figured I'd post the preliminaries in the mean time which will not change and can be applied independently without problems.

Danny Milosavljevic (1):
  ASoC: sun4i-codec: Distinguish sun4i from sun7i

 sound/soc/sunxi/sun4i-codec.c | 66 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 12 deletions(-)

-- 
2.1.4
