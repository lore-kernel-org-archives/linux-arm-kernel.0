From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 Jun 2012 11:23:18 -0500
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <20120612154735.GB19410@gmail.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <20120612154735.GB19410@gmail.com>
Message-ID: <4FD76CF6.8090801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 10:47 AM, Mike Turquette wrote:
> On 20120612-09:41, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This series defines clock bindings for Device-Tree and adds kernel
>> support using the common clock infrastructure. The last patch enables
>> DT clock support for the Calxeda Highbank platform.
>>
>> I'm posting this again to solicit further review. There has been some
>> discussion[1], but no definite path forward. This series is not changed
>> from the last post other than rebasing to v3.5-rc2.
>>
> 
> Hi Rob,
> 
> Just FYI, I was following the first thread but it did not seem to reach
> resolution.  Namely Saravana seemed to have some lingering concerns.
> But I'm definitely not ignoring this series.  I assume you still want
> this to go through me once everyone is on board?

Right. This is why I have reposted and copied those whom commented on my
pull request. I think at least some of Saravana's concerns boiled down
to not requiring using DT clock bindings and not requiring driver
changes to move to DT bindings. Both of these are met with this series.
A platform can still use clkdev tables for binding clocks to devices and
does not have to use DT for clocks. Drivers generally should not require
any changes that I'm aware of, but if there are any concrete examples
I'd like to know.

Yes, I think this should go thru you.

Rob
