From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Feb 2014 11:20:13 +0100
Subject: [PATCH 1/3] ARM: at91: Add at91sam9rl DT SoC support
In-Reply-To: <1392426860-19589-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1392426860-19589-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1392426860-19589-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140217112013.723a4e12@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Sat, 15 Feb 2014 02:14:18 +0100, Alexandre Belloni wrote:

> +	model = "Atmel AT91SAM9RL family SoC";
> +	compatible = "atmel,at91sam9rl";

Since you have it in your board .dts file, I guess you should add the
atmel,at91sam9 compatible string here:

	compatible = "atmel,at91sam9rl", "atmel,at91sam9";

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
