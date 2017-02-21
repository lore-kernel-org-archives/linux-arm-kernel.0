From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Feb 2017 23:22:42 +0100
Subject: [PATCH v3 1/3] rtc: armada38x: Prepare driver to manage
 different versions
In-Reply-To: <20170220173850.8640-2-gregory.clement@free-electrons.com>
References: <20170220173850.8640-1-gregory.clement@free-electrons.com>
 <20170220173850.8640-2-gregory.clement@free-electrons.com>
Message-ID: <20170221222242.n5pdpmrjk5wie5wq@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/2017 at 18:38:48 +0100, Gregory CLEMENT wrote:
> In order to prepare the introduction of the A7K/A8K version of the RTC,
> this commit introduces a new data structure. This structure allows to
> handle the differences between the integration of the RTC IP in the
> SoCs. It will be:
>  - MBUS bridge timing initialization
>  - IRQ configuration at SoC level
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/rtc/rtc-armada38x.c | 152 +++++++++++++++++++++++++++++---------------
>  1 file changed, 99 insertions(+), 53 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
