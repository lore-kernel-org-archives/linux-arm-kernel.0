From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:17:09 -0800
Subject: [PATCH] ARM: qcom_defconfig: Enable RPM/RPM-SMD clocks
In-Reply-To: <20161117152026.10491-1-georgi.djakov@linaro.org>
References: <20161117152026.10491-1-georgi.djakov@linaro.org>
Message-ID: <20161119011709.GA1722@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:20:26PM +0200, Georgi Djakov wrote:
> Enable support for clocks, controlled by the RPM processor on
> Qualcomm platforms.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Hi,

Please send patches like these to the platform maintainer (i.e. Andy
Gross), and leave arm at kernel.org off of Cc.

We prefer that only maintainers email us at this address to avoid getting
cc:d on everything (and dealing with the volume of email that entails).


Thanks!

-Olof
