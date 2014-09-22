From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 22 Sep 2014 23:21:41 +0100
Subject: [PATCH 0/3] media:st-rc: Misc fixes.
Message-ID: <1411424501-12673-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Thankyou for the "[media] enable COMPILE_TEST for media drivers" patch
which picked up few things in st-rc driver in linux-next testing.

Here is a few minor fixes to the driver, could you consider them for
the next merge window.

Thanks,
srini

Srinivas Kandagatla (3):
  media: st-rc: move to using reset_control_get_optional
  media: st-rc: move pm ops setup out of conditional compilation.
  media: st-rc: Remove .owner field for driver

 drivers/media/rc/st_rc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
1.9.1
