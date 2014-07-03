From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 03 Jul 2014 15:32:21 +0200
Subject: [GIT PULL] STiH407 reset controller support
In-Reply-To: <20140703094001.GB32208@lee--X1>
References: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
 <1404317194.4109.13.camel@paszta.hi.pengutronix.de>
 <20140702165924.GB17665@lee--X1> <53B50EFD.2070007@st.com>
 <1404379248.18039.31.camel@paszta.hi.pengutronix.de>
 <20140703094001.GB32208@lee--X1>
Message-ID: <1404394341.18039.35.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Donnerstag, den 03.07.2014, 10:40 +0100 schrieb Lee Jones:
> On Thu, 03 Jul 2014, Philipp Zabel wrote:
> > Patch 4 depends on patch 1 for the header. My tree is still empty, how
> > about I take the first two, and you merge that branch and then take 3
> > and 4 on top?
> 
> That approach sounds reasonable.  Once you've applied the patches can
> you tag the branch and provide Maxime with a pull-request please
> Philipp?

The following changes since commit
7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-sti-3.17

for you to fetch changes up to d29d2a38d1c1b21730487e991183ffe7e16e1ef5:

  reset: sti: Document sti-picophyreset controllers bindings.
(2014-07-03 14:58:22 +0200)

----------------------------------------------------------------
STiH407 reset controller support

----------------------------------------------------------------
Peter Griffin (2):
      reset: stih407: Add softreset, powerdown and picophy controllers
      reset: sti: Document sti-picophyreset controllers bindings.

 .../bindings/reset/st,sti-picophyreset.txt         |  42 ++++++
 drivers/reset/sti/Kconfig                          |   4 +
 drivers/reset/sti/Makefile                         |   1 +
 drivers/reset/sti/reset-stih407.c                  | 158
+++++++++++++++++++++
 .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++++++
 5 files changed, 266 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
 create mode 100644 drivers/reset/sti/reset-stih407.c
 create mode 100644
include/dt-bindings/reset-controller/stih407-resets.h

regards
Philipp
