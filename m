From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 5 Mar 2015 13:00:58 +0800
Subject: [PATCH 0/3] media: atmel-isi: rework on the clock part and add
 runtime pm support
Message-ID: <1425531661-20040-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fix the peripheral clock code and enable runtime pm
support.
Aslo clean up the code which is for the compatiblity of mck.


Josh Wu (3):
  media: atmel-isi: move the peripheral clock to start/stop_stream()
    function
  media: atmel-isi: add runtime pm support
  media: atmel-isi: remove mck back compatiable code as we don't need it

 drivers/media/platform/soc_camera/atmel-isi.c | 72 +++++++++++++--------------
 1 file changed, 34 insertions(+), 38 deletions(-)

-- 
1.9.1
