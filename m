From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Oct 2018 07:23:19 -0700
Subject: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
In-Reply-To: <ff68a664-aa7a-92b6-b78c-78382f7b0ec1@ti.com>
References: <20180925144021.GN5662@atomide.com>
 <20180925175537.GQ5662@atomide.com>
 <d98aa7c1-5131-34c5-51e5-c7ef57cbc31e@ti.com>
 <20180926155911.GT5662@atomide.com>
 <20180926162303.GU5662@atomide.com>
 <cfc3f1db-9468-ed92-a673-882b51b4dec8@ti.com>
 <20180926233111.GY5662@atomide.com>
 <305bf1c3-915d-dac1-95e4-4d32621247e1@ti.com>
 <20181001163253.GW5662@atomide.com>
 <ff68a664-aa7a-92b6-b78c-78382f7b0ec1@ti.com>
Message-ID: <20181004142319.GA5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [181004 04:34]:
> Apologies for the delay in responding.
> 
> AM437X-GP-EVM: https://pastebin.ubuntu.com/p/m3ybBvH7Qj/
> 
> Tested for UART/RTCWAKE/TOUCH_WAKE from DS0, apart from the expected
> gpio warnings all seems fine.
> 
> AM335X-BONEBLACK: https://pastebin.ubuntu.com/p/xdsMDS5XtQ/
> 
> Tested for rtcwake/UART wake up from DS0. Again except for gpio messages
> everything else seems to be fine.

OK good to hear and thanks for testing again :) I've sent
a pull request for the ti-sysc driver changes, the dts
changes for am335x, am437x and dra7 will have to wait until
v4.21 merge window at this point. Let's plan on having the
dts changes sit in Linux next for a few weeks right after
v4.20-rc1.

Regards,

Tony
