From: marcel@holtmann.org (Marcel Holtmann)
Date: Tue, 25 Feb 2014 09:59:07 -0800
Subject: [PATCHv2 0/5] net: rfkill: gpio: cleanup and a few new acpi ids
In-Reply-To: <1393341068.4170.7.camel@jlt4.sipsolutions.net>
References: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1393341068.4170.7.camel@jlt4.sipsolutions.net>
Message-ID: <D8A6682F-CC21-4428-AFA3-C50FBA8ED1F7@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Johannes,

>> I was waiting for the DT support from Chen-Yu before sending these,
>> but decided it makes no difference when I send them. I'm dropping the
>> con ID in the second patch because Dan noticed the warning, but of
>> course it will mean the "gpios" property can be used with DT.
>> 
>> The two last patches just add ACPI IDs for some new Baytrail based
>> boards.
> 
> Do these patches have any dependencies, or should I just add them to the
> mac80211-next tree (since I don't keep a separate rfkill tree)?
> 
> Or does anyone else want to take them? In that case, it's all fine with
> me, I'm really just nominally the rfkill maintainer and have no idea
> about these patches... :)

someone has to take them. So I say go for it.

Regards

Marcel
