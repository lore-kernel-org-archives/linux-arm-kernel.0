From: lho@apm.com (Loc Ho)
Date: Thu, 27 Feb 2014 11:57:44 -0800
Subject: [PATCH v12 1/4] PHY: Add function set_speed to generic PHY
 framework
In-Reply-To: <20140227190102.GB4862@saruman.home>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
 <20140227190102.GB4862@saruman.home>
Message-ID: <CAPw-ZT=F07=T0=z=iT=hxJ0+609RBDYRL=MXF5dQoEowLjsRjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Balbi,

> On Thu, Feb 27, 2014 at 11:14:05AM -0700, Loc Ho wrote:
>> This patch adds function set_speed to the generic PHY framework operation
>> structure. This function can be called to instruct the PHY underlying layer
>> at specified lane to configure for specified speed in hertz.
>
> why ? looks like clk_set_rate() is your friend here. Can you be more
> descriptive of the use case ? When will this be used ?
>

The phy_set_speed is used to configure the operation speed of the PHY
at run-time. The clock interface in general is used to configure the
clock input to the IP. I don't believe they are the same thing. Maybe
it will be clear in my response to your second email

-Loc
