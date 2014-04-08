From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Tue,  8 Apr 2014 17:21:47 +0200
Subject: [PATCH 0/2] pinctrl: st: Driver fixing & clean-up
Message-ID: <1396970509-28009-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is composed of two patches for ST pinctrl driver.

The first one makes use of const qualifier where applicable, as reported by
Joe Perches in the series adding support to STiH407 SoC.

The second one makes use of ARRAY_SIZE to pass the STiH415's delays table
size, instead of passing the raw value. This correction had already been done
for STiH416 table.

Maxime Coquelin (2):
  pinctrl: st: Use const qualifier when required
  pinctrl: st: Use ARRAY_SIZE for STiH415 data

 drivers/pinctrl/pinctrl-st.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
1.9.0
