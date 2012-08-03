From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Aug 2012 21:00:51 -0300
Subject: [PATCH] ARM: dts: imx: fix gpio interrupts property
In-Reply-To: <CAOMZO5A3hRp1f-244cPPE15Ur-V6stANrQ2QrS5j58J3BMRnXQ@mail.gmail.com>
References: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
 <1343917434-4358-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5A3hRp1f-244cPPE15Ur-V6stANrQ2QrS5j58J3BMRnXQ@mail.gmail.com>
Message-ID: <CAOMZO5ABZzR=xkpvBt0oAt0b_po3SsDOFcG7--30ukwiqKiYWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2012 at 4:46 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Still see an issue with gpio-key, but I guess it is because
> http://patches.linaro.org/2743/
> is missing.

The gpio-key crash is caused by 30161f6b2e7d1 (Input: gpio_keys -
clean up device tree
parser ). If I revert it, the gpio-key is correctly probed.

I have reported this in linux-input list.

Regards,

Fabio Estevam
