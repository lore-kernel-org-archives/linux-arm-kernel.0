From: davem@davemloft.net (David Miller)
Date: Tue, 22 Jul 2014 13:16:39 -0700 (PDT)
Subject: [PATCH 0/6] net: mvpp2: Assorted fixes
In-Reply-To: <20140722144519.GA682@arch.cereza>
References: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140721.202749.913689946944612851.davem@davemloft.net>
 <20140722144519.GA682@arch.cereza>
Message-ID: <20140722.131639.1180592286226896307.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date: Tue, 22 Jul 2014 11:45:19 -0300

> On 21 Jul 08:27 PM, David Miller wrote:
>> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> Date: Mon, 21 Jul 2014 13:48:10 -0300
>> 
>> > This patchset contains a set of fixes for issues found while doing some
>> > more intensive tests on the recently accepted mvpp2 ethernet driver.
>> > 
>> > David: if we are still in time, we'd like to get the driver fixes merged
>> > for v3.17-rc1.
>> > 
>> > For the devicetree changes, it's already too late for that, since Jason
>> > Cooper has already posted the PRs for v3.17. I'll re-post them when
>> > v3.17-rc1 is released.
>> > 
>> > As usual, feedback is welcome.
>> 
>> This series does not apply to the 'net' tree at all, please respin
>> and resubmit.
> 
> This series applies on net-next.
> 
> Sorry for not mentioning it,

They are bonafide bug fixes, therefore should be targetted at 'net'.
