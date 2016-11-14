From: davem@davemloft.net (David Miller)
Date: Mon, 14 Nov 2016 12:32:53 -0500 (EST)
Subject: [PATCH 0/5] net: thunderx: Miscellaneous fixes
In-Reply-To: <2948c47d-0f15-8153-440b-7a2c753b7251@suse.com>
References: <1479120886-13425-1-git-send-email-sunil.kovvuri@gmail.com>
 <2948c47d-0f15-8153-440b-7a2c753b7251@suse.com>
Message-ID: <20161114.123253.476733911183519472.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>
Date: Mon, 14 Nov 2016 13:01:25 +0100

> 
> 
> On 14/11/16 11:54, sunil.kovvuri at gmail.com wrote:
>> From: Sunil Goutham <sgoutham@cavium.com>
>>
>> This patchset includes fixes for incorrect LMAC credits,
>> unreliable driver statistics, memory leak upon interface
>> down e.t.c
>>
> 
> Are these fixes relevant to for older kernels as well?
> If so, please add "Cc: stable at vger.kernel.org" to the Sigend-off list.

This is not appropriate for networking patches.

People instead explicitly request -stable inclusion when the
submit networking changes to me, and I queue them up for
later submission.
