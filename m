From: stefan@agner.ch (Stefan Agner)
Date: Tue, 28 Oct 2014 23:17:02 +0100
Subject: [PATCHv6 0/6] ARM: imx: Add Freescale LS1021A SoC and board
 support
In-Reply-To: <1414335419636.17637@freescale.com>
References: <1414145327-23541-1-git-send-email-jingchang.lu@freescale.com>,
 <20141026002354.GC6973@tiger> <1414335419636.17637@freescale.com>
Message-ID: <7bd04bef7b8e2eb701a4fe91603a0dc1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-10-26 15:57, schrieb Jingchang Lu:
<snip>
>>> ---
>>> changes in v6:
>>>  add dts patch description.
>>>  remove '-' from QDS and TWR board dts name for consistence with u-boot.
> 
>>I'm not sure it's a good idea.  The most idiomatic DTS naming schema is
> just <socname>-<boardname>.dts.
> Many our PowerPC platforms doesn't have '-' between SoCs and board
> names. This becomes a project requirement when integrating in our SDK
> release, and I have renamed these board names internally, so I also
> rename them on upstream for consistence. Thanks.

Especially since this SoC has a letter in the end, its quite hard to
tell what is the SoC name and what is the board name. Hence I vote for
the hyphen too.

--
Stefan

> 
> Best Regards,
> Jingchang
> 
>>Shawn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
