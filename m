From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Apr 2014 09:32:31 -0600
Subject: [PATCHv3 0/5] net: rfkill: gpio: cleanup and a few new acpi ids
In-Reply-To: <20140409100147.GB3083@xps8300>
References: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1396946275.5936.2.camel@jlt4.sipsolutions.net>
 <20140409100147.GB3083@xps8300>
Message-ID: <5345680F.3040903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2014 04:01 AM, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Apr 08, 2014 at 10:37:55AM +0200, Johannes Berg wrote:
>> On Tue, 2014-04-01 at 17:02 +0300, Heikki Krogerus wrote:
>>> I hope this one is OK with everyone.
>>
>> It's fine with me. Are you expecting me to pick up any of these patches,
>> or do you want them to go through some other tree? Either way is fine
>> with me, but the first patch looks like something I probably shouldn't
>> be taking.
> 
> The second patch depends on it.
> 
> Stephen! Are you expecting any changes to board-paz00.c in this kernel
> cycle? If not, I think it would be easiest if Johannes, you take the
> whole set. What do you guys think?

I can't predict the future, but the chances are pretty slim - that file
is pretty tiny and doesn't have much churn.

The best approach is to put this series in its own topic branch. Then,
if any conflict does come up, I can simply merge the branch into the
Tegra treee and apply the conflicting patches on top.
