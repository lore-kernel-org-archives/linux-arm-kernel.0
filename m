From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 13 Apr 2013 03:07:05 +0400
Subject: [PATCH v2 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <87txnfjhmu.wl%kuninori.morimoto.gx@renesas.com>
References: <201304090110.50154.sergei.shtylyov@cogentembedded.com>
 <87zjx89rfb.wl%kuninori.morimoto.gx@renesas.com>
 <51640D21.3090800@cogentembedded.com>
 <87txnfjhmu.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51689399.5090203@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/10/2013 05:31 AM, Kuninori Morimoto wrote:

>
>>> Please add this "tested on xxx" comment on each patch's log area, not only on [0/x].
>>> We need it on "git log"
>>      I'm going to post R8A7778/BOCK-W series following this one, and all the
>> patches in 1st series should additionally be tested on BOCK-W. Well, I
>> probably can hold up posting version 3 until I have the second series verified.
>>      BTW, about R8A7778/BOCK-W, R-Car M1A user manual talks about a ferrite
>> bead in 49.4.1 (3) Setting USB-PHY. Do you know for sure if it's used or not
>> on BOCK-W board? PHY initialization seems to work with either settings...
> I can ask it to HW team if you want me.
> But our local BSP is using "No ferrite bead" settings...

    I've rummaged thru the BSP I have and found not traces of a ferrite bead
(and rcar-phy driver as well) in the patches...

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei
