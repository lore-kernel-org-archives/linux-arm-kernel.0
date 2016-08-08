From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 8 Aug 2016 12:08:35 +0200
Subject: [PATCH v2 2/2] ARM: dts: at91: sama5d2: add ETM and ETB nodes
In-Reply-To: <1467705950-29482-2-git-send-email-olivier.schonken@gmail.com>
References: <1467705950-29482-1-git-send-email-olivier.schonken@gmail.com>
 <1467705950-29482-2-git-send-email-olivier.schonken@gmail.com>
Message-ID: <20160808100835.GK8132@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2016 at 10:05:50 +0200, Olivier Schonken wrote :
> Add node to support SAMA5D2 Embedded Trace Macrocell and Embedded
> Trace Buffer.
> 
> This patch depends on coresight-etm3x: Add ARM ETM-A5 peripheral ID
> for proper coresight functionality.
> It also depends on clocksource: timer-atmel-pit: enable mck to not
> stall SAMA5D2 on bootup.
> 
> Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
