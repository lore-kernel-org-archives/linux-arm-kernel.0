From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Apr 2016 09:15:40 +0200
Subject: [PATCH] ARM: dts: at91: VInCo: fix phy reset gpio flag
In-Reply-To: <571FB305.4060304@cogentembedded.com>
References: <570BF481.9070903@cogentembedded.com>
 <1461666272-10107-1-git-send-email-nicolas.ferre@atmel.com>
 <20160426.131750.433048061726795876.davem@davemloft.net>
 <571FB305.4060304@cogentembedded.com>
Message-ID: <5720671C.9040406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/04/2016 20:27, Sergei Shtylyov a ?crit :
> On 04/26/2016 08:17 PM, David Miller wrote:
> 
>>> I plan to queue this patch through arm-soc for 4.7.
>>
>> Ok.
> 
>     How about this patch going thru your net-next repo instead?
> I'd like to keep the kernel bisectable... if my phylib/macb patches get merged 
> earlier than this one, that board would be broken...

Sergei, David,

I don't think that there is a big risk for this board to be tested in
the meantime as it's not widely deployed yet.
And as I'm aware of the issue and basically maintaining this DT file, I
think that I'll be informed if people try an unlikely arrangement of
patches on this board.

So either way, I'm okay. But I do think it's not worth thinking too much
about this case.

Bye,
-- 
Nicolas Ferre
