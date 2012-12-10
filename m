From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 23:37:23 +0100
Subject: [PATCH 1/2] arm: mvebu: add RTC support for Armada 370 and
 Armada XP
In-Reply-To: <20121210214755.9CD823E0C7C@localhost>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
 <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
 <20121210162819.46fe4f91@skate>
 <20121210214755.9CD823E0C7C@localhost>
Message-ID: <20121210233723.1f3656d0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

On Mon, 10 Dec 2012 21:47:55 +0000, Grant Likely wrote:

> > Maybe an explicit status = "okay" here?
> 
> Only necessary if it is typical for the device to get disabled. I don't
> add status="okay" properties unless it is to enable a device previously
> disabled with status="disabled"

Ok, thanks for clarifying what the best practice is. This device being
internal to the SoC and having no dependency on external components, it
is indeed always available.

Thanks again for the clarification!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
