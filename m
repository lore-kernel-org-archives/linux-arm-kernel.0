From: davem@davemloft.net (David Miller)
Date: Tue, 22 Jul 2014 19:52:22 -0700 (PDT)
Subject: [PATCH 0/6] net: mvpp2: Assorted fixes
In-Reply-To: <20140722.174153.413669013449137654.davem@davemloft.net>
References: <20140723002916.67a0bb3c@free-electrons.com>
 <20140722232004.GA7838@arch.cereza>
 <20140722.174153.413669013449137654.davem@davemloft.net>
Message-ID: <20140722.195222.775371949777233094.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 17:41:53 -0700 (PDT)

> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date: Tue, 22 Jul 2014 20:20:04 -0300
> 
>> On 23 Jul 12:29 AM, Thomas Petazzoni wrote:
>>> On Tue, 22 Jul 2014 13:16:39 -0700 (PDT), David Miller wrote:
>>> 
>>> > >> This series does not apply to the 'net' tree at all, please respin
>>> > >> and resubmit.
>>> > > 
>>> > > This series applies on net-next.
>>> > > 
>>> > > Sorry for not mentioning it,
>>> > 
>>> > They are bonafide bug fixes, therefore should be targetted at 'net'.
>>> 
>>> Except that I believe they are fixes for a driver which itself is in
>>> net-next, i.e scheduled for 3.17.
>>> 
>> 
>> That's right. These are fixes for the new mvpp2 driver, which is only
>> in net-next.
> 
> Ok, I queued them back up, thanks for the clarification.

I've applied the 4 driver patches to net-next.  But, since the ARM
device tree file changes did not go into net-next, I can't apply the
last two patches to my tree.  You'll need to sort that out yourself.

It's a bit unfortunate that things are now out of sync like this, but
that's what you asked me to do.
