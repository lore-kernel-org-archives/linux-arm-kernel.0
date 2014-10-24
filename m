From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 24 Oct 2014 23:41:29 +0200
Subject: [PATCHv0 2/2] arm: mvebu: clarify (e)SATA ports info in NETGEAR
 ReadyNAS 102 .dts file
In-Reply-To: <20141024212207.GC6436@lunn.ch> (Andrew Lunn's message of "Fri,
 24 Oct 2014 23:22:07 +0200")
References: <cover.1414185031.git.arno@natisbad.org>
 <4af680f9a68281755e31df2491f0590046138230.1414185031.git.arno@natisbad.org>
 <20141024212207.GC6436@lunn.ch>
Message-ID: <87wq7pi1rq.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andrew Lunn <andrew@lunn.ch> writes:

> On Fri, Oct 24, 2014 at 11:22:16PM +0200, Arnaud Ebalard wrote:
>> 
>> On NETGEAR ReadyNAS 102, the two disks are connected to the external
>> Marvell 88SE9170 SATA Controller connected to the PCIe bus. The rear
>> eSATA port is connected to the native Armada 370 SATA controller.
>> 
>> This patch updates the comments in .dts file wrt SATA interfaces and
>> reduces the number of ports for native Armada 370 interface from 1
>> to 2.
>
> Typ0. 
>
> Jason, can you swap the 1 and 2 around when you commit?
> Save having a v2.
>
> Otherwise
>
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Good catch. Thanks, Andrew.

Cheers,

a+
