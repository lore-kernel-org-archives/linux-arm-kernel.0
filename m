From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 16:00:37 -0700
Subject: [PATCH v2 0/9] ARM: DRA7: Add support for DRA718-evm
In-Reply-To: <1b9c4d14-78d7-841f-776c-63a8c1ae1fb1@ti.com>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <1b9c4d14-78d7-841f-776c-63a8c1ae1fb1@ti.com>
Message-ID: <20161109230037.GP2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [161106 20:50]:
> Hi Tony,
> 
> On Friday 21 October 2016 04:08 PM, Lokesh Vutla wrote:
> > This series does minor dts cleanup for dra72-evm and adds support for
> > DRA718-evm.
> 
> Do you have any comments on this series?

Looks good to me except for the regulator patch that you need to repost.
Applying the rest split into various topic branches for soc/dt/defconfig.

Regards,

Tony
