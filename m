From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 29 Nov 2017 11:16:50 +0100
Subject: [GIT PULL] tee fix for v4.15
Message-ID: <20171129101649.3vrhocn65gzbhvkp@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maiantainers,

Please pull this OP-TEE driver init fix for v4.15

Thanks,
Jens

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-fix-for-4.15

for you to fetch changes up to f044113113dd95ba73916bde10e804d3cdfa2662:

  optee: fix invalid of_node_put() in optee_driver_init() (2017-11-29 10:24:57 +0100)

----------------------------------------------------------------
One small fix for optee_driver_init()

* Fixes problem with an invalid call to of_node_put() in
  optee_driver_init()

----------------------------------------------------------------
Jens Wiklander (1):
      optee: fix invalid of_node_put() in optee_driver_init()

 drivers/tee/optee/core.c | 1 -
 1 file changed, 1 deletion(-)
