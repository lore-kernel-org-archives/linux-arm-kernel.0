From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 16:28:19 +0100
Subject: [PATCH 1/2] arm: mvebu: add RTC support for Armada 370 and
 Armada XP
In-Reply-To: <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
 <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121210162819.46fe4f91@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 10 Dec 2012 11:42:01 +0100, Gregory CLEMENT wrote:

> +		rtc at 10300 {
> +			compatible = "marvell,orion-rtc";
> +			reg = <0xd0010300 0x20>;
> +			interrupts = <50>;
> +		};

Maybe an explicit status = "okay" here?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
