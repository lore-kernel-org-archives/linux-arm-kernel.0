From: jan.kundrat@cesnet.cz (=?iso-8859-1?Q?Jan_Kundr=E1t?=)
Date: Wed, 12 Sep 2018 21:00:35 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
In-Reply-To: <20180912205052.19de01a0@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912205052.19de01a0@windsurf>
Message-ID: <7745d264-5d11-42a1-b491-95887a807894@cesnet.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> You mean '4.19-rc3', right?

Right, sorry.

>>>> [    1.741458] Internal error: Oops - undefined instruction: 
>>>> 0 [#1] SMP ARM
>>>> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G   
>>>>      W         4.19.0-rc3 #1  
>> 
>> The 'W' taint means that there was a kernel warning before. Which
>> warning was that?

I have "spidev" listed in my DT, and the kernel complains about that; 
that's a harmelss warning. (I sent a patch which adds my particular device 
into the spidev driver some time ago.) 

With kind regards,
Jan
