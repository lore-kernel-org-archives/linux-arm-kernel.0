From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 30 Apr 2013 07:19:02 +1200
Subject: [PATCHv2 0/3] Add support for velocity network driver on platform
 devices
In-Reply-To: <20130429.151528.2251094691456287740.davem@davemloft.net>
References: <1367221841-14563-1-git-send-email-linux@prisktech.co.nz>
 <20130429.151528.2251094691456287740.davem@davemloft.net>
Message-ID: <517EC7A6.9030204@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/13 07:15, David Miller wrote:
> You prepared these patches against a net-next tree which is at least
> a week old, I know this because that's when the NETIF_F_* flags for
> VLAN offloading changed their names which causes your third patch
> to fail to apply.
>
> Do not do this, net-next changes every day and rapidly, don't take
> the chance that the driver you're touching is unpopular and thus
> hasn't had changes to it recently.  Tree-wide interface changes
> happen all the time.
Apologies - I didn't realise. These patches are based against 3.8-rc8.
I will rebase against net-next and resend.

Regards
Tony P
