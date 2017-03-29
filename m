From: sfaragnaus@gmail.com (Andrea della Porta)
Date: Wed, 29 Mar 2017 06:15:34 +0100
Subject: staging: vc04_services: bcm2835-audio Fixed checkpatch issues
Message-ID: <cover.1490760735.git.sfaragnaus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed several chekpatch warnign about alignment of function parameters,
removed spaces after a cast, split one line that was over 80 chars

 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 48 +++++++++++-----------
 1 file changed, 23 insertions(+), 25 deletions(-)
