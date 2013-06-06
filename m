From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:16:48 +0100
Subject: [PATCH 00/32] ARM: ux500: Enable clocks for Device Tree
Message-ID: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After this patchset has been applied, we can request clocks directly
from Device Tree without using any AUXDATA device-name hacks. We also
take care to remove all of thos at the end of the set.
