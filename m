From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 14:22:57 +1200
Subject: [PATCHv6 0/3] Add support for velocity network driver on platform
 devices
In-Reply-To: <20130517.173644.1877140985770026320.davem@davemloft.net>
References: <1368768078-16121-1-git-send-email-linux@prisktech.co.nz>
 <20130517.141938.2120801813213703422.davem@davemloft.net>
 <20130517.173644.1877140985770026320.davem@davemloft.net>
Message-ID: <5196E601.10202@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/13 12:36, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Fri, 17 May 2013 14:19:38 -0700 (PDT)
>
>> Series applied, thanks.
> I'm reverting this, you're not using the correct types for the PM
> functions you're hooking up.
>
> drivers/net/ethernet/via/via-velocity.c:3238:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/net/ethernet/via/via-velocity.c:3238:8: warning: (near initialization for ?velocity_pm_ops.suspend?) [enabled by default]
> drivers/net/ethernet/via/via-velocity.c:3238:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/net/ethernet/via/via-velocity.c:3238:8: warning: (near initialization for ?velocity_pm_ops.freeze?) [enabled by default]
> drivers/net/ethernet/via/via-velocity.c:3238:8: warning: initialization from incompatible pointer type [enabled by default]
> drivers/net/ethernet/via/via-velocity.c:3238:8: warning: (near initialization for ?velocity_pm_ops.poweroff?) [enabled by default]
Argh.. sorry Dave.
I forgot to merge the fixup for this before sending. Fixed version to 
follow.

Regards
Tony P
