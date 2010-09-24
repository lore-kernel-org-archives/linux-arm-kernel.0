From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Fri, 24 Sep 2010 12:23:45 -0700
Subject: [RFC] SoC name and revision in /proc/cpuinfo
In-Reply-To: <20100924144249.GB17651@game.jcrosoft.org>
References: <20100924135356.GA17651@game.jcrosoft.org>	<20100924140652.GA14809@n2100.arm.linux.org.uk>
	<20100924144249.GB17651@game.jcrosoft.org>
Message-ID: <4C9CFAC1.7030006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2010 07:42 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> I knwon the diff between cpu and soc but today others arch do this the same way
> via cpuinfo as example sh or others.
> 
> So what do you propose?
> 
> is this better
> 
> soc familly:	at91
> soc type:	at91am9g20
> soc revision:	1.1
> 
> or you will prefer we create a new entry like sysinfo?
> 
> because today we store the hardware name, revision abd serial in cpuinfo
> also
> 
> Best Regards,
> J.

How about something like /sys/devices/system/soc/soc0/[family|type|revision]?  We're doing something similar and using this location on MSM chips.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
