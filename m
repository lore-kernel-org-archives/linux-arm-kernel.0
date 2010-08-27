From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 27 Aug 2010 07:11:58 -0700
Subject: [PATCH v4] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <4C7702EB.8040905@criticallink.com> (Michael Williamson's message
	of "Thu, 26 Aug 2010 20:12:27 -0400")
References: <4C516634.5040804@criticallink.com>
	<877hjd106u.fsf@deeprootsystems.com>
	<4C7702EB.8040905@criticallink.com>
Message-ID: <8762ywrvpt.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

>> Normally, I like to see new board support broken down more.  It's rather
>> difficult to do a good review of new board file when everything is added
>> in a single patch.
>>
>> Typically, a basic patch that just supports basic boot (typically to
>> UART console) is the first patch.  Then additional patches are added to
>> add peripheral support (display, MMC, SPI, flash, regulators, ...)
>>
>> Breaking things up this way helps reviewers and maintainers greatly.
>>
>> [...]
>>    
> OK.  Most of the board file is a large cut-and-paste of the da850
> EVM.  It seems unlikely that I'll have any measure of success here, but if
> I get time I might try again.

OK, if it's mostly a cut-and-paste of da850, then maybe just break it up
into two patches, 1) the cut, paste & rename patch and 2) a separate
patch for things that are different on your board.

Thanks,

Kevin
