From: s-anna@ti.com (Suman Anna)
Date: Tue, 9 Sep 2014 11:15:22 -0500
Subject: [PATCHv3 0/5] OMAP Mailbox framework adoption & DT support
In-Reply-To: <20140909025225.GI10785@atomide.com>
References: <1406680479-18446-1-git-send-email-s-anna@ti.com>
 <20140908232053.GS3238@atomide.com> <20140909025225.GI10785@atomide.com>
Message-ID: <540F279A.1080700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 09/08/2014 09:52 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140908 16:21]:
>> * Suman Anna <s-anna@ti.com> [140729 17:37]:
>>> Hi,
>>>
>>> This is an updated version of the OMAP Mailbox framework adoption &
>>> DT support series, refreshed to work with the v9 version of the mailbox
>>> framework [1] from Jassi Brar while also addressing some minor review
>>> comments. Detailed changes are summarized below. Patches are based on
>>> 3.16-rc2.
>>
>> Sorry for the delay, just noticed that I'm supposed to queue
>> these too. I'll queue these into omap-for-v3.18/mailbox against
>> v3.17-rc1 and will probably also merge it into omap-for-v3.18/dt
>> as well.
> 
> Actually this is not compiling and seems to probably miss
> the dependencies from Jassi, so dropping the branch.

The last 2 patches which is the framework adoption portion needs the
framework patches from Jassi (as stated in the cover letter). I will
ping on the framework thread to see if it is making it into 3.18. In any
case, we should be able to take the first three patches (2 in drivers
and 1 for DT) - they are independent of the framework and also are
dependencies for the framework adoption patches.

> Anyways, since it seems you need to repost this again, please
> repost the DT changes separately from the driver changes.

Yeah, the other two dependent series are merged for 3.17, so these are
the only patches remaining. I just need to repost them on a 3.17-rc, but
there are no changes required (even with v10 of the framework). So given
above, do you want me to split the first 3 (there is one DT patch) and
post them so that they can be merged for 3.18?

regards
Suman
