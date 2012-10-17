From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Oct 2012 19:25:28 +0000
Subject: [GIT PULL 2/3] ARM: mvebu: fix for v3.7
In-Reply-To: <pull-1350501943-114231>
Message-ID: <mailman.25.1350501982.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_gpio_fixes_for_v3.7

for you to fetch changes up to 7cf8c9f7810ec1b9feaaa7914aaec4fc73c0c5d5:

  gpio: mvebu: Add missing breaks in mvebu_gpio_irq_set_type (2012-10-17 17:40:18 +0000)

----------------------------------------------------------------
Depends:
 - Based on v3.7-rc1

Adds:
 - missing break;s from converting if{}s to switch{}

----------------------------------------------------------------
Axel Lin (1):
      gpio: mvebu: Add missing breaks in mvebu_gpio_irq_set_type

 drivers/gpio/gpio-mvebu.c | 3 +++
 1 file changed, 3 insertions(+)
