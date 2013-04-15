From: mpfj-list@mimc.co.uk (Mark Jackson)
Date: Mon, 15 Apr 2013 18:28:25 +0100
Subject: [PATCH 0/3] Dual EMAC mode implementation of CPSW
In-Reply-To: <516C33D2.4050105@ti.com>
References: <1360612340-9266-1-git-send-email-mugunthanvnm@ti.com>
 <516B0098.4040809@mimc.co.uk> <516C33D2.4050105@ti.com>
Message-ID: <516C38B9.50904@mimc.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/13 18:07, Mugunthan V N wrote:
> On 4/15/2013 12:46 AM, Mark Jackson wrote:

<snip>

>>
>> Notice that at the end, the nfs link appears to come back "ok", but
>> the "ps" command never completes.
>>
>> Any ideas of what's going on ?
>
> I have tried ping on both the interface fine. Will verify with ps again
> later in this week.
> Can you provide below details details
> - Are you using EVMsk or custom build EVM?

This is a custom board (based on the BeagleBone design) with dual 
Ethernet, NAND, NOR and FRAM.

The dual emac thing is (one of) the last things to get signed off, so 
I'm willing to assist in tracking this down.

Regards
Mark J.
