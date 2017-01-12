From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 12:11:47 +0000
Subject: [PATCH v2 2/2] arm64: dts: juno: Adds missing CoreSight STM
 component.
In-Reply-To: <DB6PR0802MB2198449A31AD8624B48045428C790@DB6PR0802MB2198.eurprd08.prod.outlook.com>
References: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
 <1484167449-14432-3-git-send-email-mike.leach@linaro.org>
 <0120ef9b-2e01-e00a-2de8-c540ab70af85@arm.com>
 <DB6PR0802MB2198449A31AD8624B48045428C790@DB6PR0802MB2198.eurprd08.prod.outlook.com>
Message-ID: <4388546d-f78e-e47f-5edc-eb0a78c3a27f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/17 11:24, Mike Leach wrote:
> Hi Sudeep,
> 
> I'm fine with that - less duplication the better.
> 
> I've not played with .dts files much to I hadn't realised that type
> of construction was possible.
> 

OK I spent some time and I think we can do the same for other coresight
components too. I will modify post the series but I need your help to
validate the change running core-sight tests.

-- 
Regards,
Sudeep
