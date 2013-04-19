From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Apr 2013 21:54:58 +0400
Subject: [PATCH v2 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <87a9ov74ao.wl%kuninori.morimoto.gx@renesas.com>
References: <201304090110.50154.sergei.shtylyov@cogentembedded.com>
 <87zjx89rfb.wl%kuninori.morimoto.gx@renesas.com>
 <51640D21.3090800@cogentembedded.com>
 <87txnfjhmu.wl%kuninori.morimoto.gx@renesas.com>
 <51689399.5090203@cogentembedded.com> <51689488.7040109@cogentembedded.com>
 <87mwsydklg.wl%kuninori.morimoto.gx@renesas.com>
 <87a9ov74ao.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <517184F2.8070009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/19/2013 04:27 AM, Kuninori Morimoto wrote:

>>>>>>       I'm going to post R8A7778/BOCK-W series following this one, and
>>>>>> all the
>>>>>> patches in 1st series should additionally be tested on BOCK-W. Well, I
>>>>>> probably can hold up posting version 3 until I have the second
>>>>>> series verified.
>>>>>>       BTW, about R8A7778/BOCK-W, R-Car M1A user manual talks about a
>>>>>> ferrite
>>>>>> bead in 49.4.1 (3) Setting USB-PHY. Do you know for sure if it's
>>>>>> used or not
>>>>>> on BOCK-W board? PHY initialization seems to work with either
>>>>>> settings...
>>>>> I can ask it to HW team if you want me.
>>>      Yes, ask them please.
>> Now, I'm asking it to HW team
>> Please wait
> According to HW team,
> this setting is for some kind of USB compliance test (?).
> So, in general, we can use "No ferrite bead".

    Thanks, I'll change it.

WBR, Sergei
