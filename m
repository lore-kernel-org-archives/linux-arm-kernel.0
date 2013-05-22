From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 15:22:54 +0100
Subject: [PATCH 0/7] ARM: ux500: Change naming convention for pinctrl 
Message-ID: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our naming convention started off sensibly, but with the addition of
more supported platforms it's slipped a little. Most compatible strings
standardise themselves with "<vendor>,<device_name>-<device_type>",
which we had initially with "stericsson,nmk-pinctrl", but with more
devices to support we now have a tail, so we are using
"<vendor>,<driver_name>-<device_type>-<device_name>", which is
unsuitable.

This patch-set ensures the standard convention is used again.
