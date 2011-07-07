From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 07 Jul 2011 15:30:42 +0400
Subject: [PATCH v2 0/2] Add device tree probe for imx/mxc gpio
In-Reply-To: <1309879166-25788-1-git-send-email-shawn.guo@linaro.org>
References: <1309879166-25788-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4E1598E2.4080205@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-07-2011 19:19, Shawn Guo wrote:

> The first patch removes the uses of cpu_is_mx(),

    There are 3 patches total. And this is the second patch...

> and the second one adds device tree probe support.

    ... and this is the third.

> Changes since v1:
>   * Address review comments given by Grant and Sascha
>   * Add patch #1 to get gpio range/base from gpio core

> Shawn Guo (3):
>        gpio/mxc: get gpio range/base from gpio core
>        gpio/mxc: get rid of the uses of cpu_is_mx()
>        gpio/mxc: add device tree probe support

WBR, Sergei
