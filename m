From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 15:33:05 +0000
Subject: [PATCH 0/5] Versatile Express DT support, take 2
In-Reply-To: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20111116153305.GA2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:01PM +0000, Pawel Moll wrote:
> Hello again,
> 
> I've manage to clean up the VE DT patches.
> 
> Changes since RFC:
> 
> * I think I did all the changes suggested by Rob (including
>   using "custom" clock lookups instead of auxdata - do
>   comment, please ;-)
> 
> * Merged CA5s and CA9 code into one file.
> 
> * Added documentation for the vexpress bindings.
> 
> * Reorganized the tree so the "flat aliases search" patch
>   is not longer necessary.
> 
> * Moved the alias node from motherboard's to tile's DTS,
>   as this is the place to decide about serial port ordering,
>   timers being used etc.
> 
> * Got the SMSC working (my fault, obviously ;-)
> 
> As usual - feedback more than welcome (my tests suggest
> that the "ATAG version" still works, so feel free to test
> at least that ;-)

I haven't actually tried this code out yet, but I'm broadly in
agreement.

I'm happy for this series to replace my previously posted
series, since it builds on common changes.

I have a few comments on the detail -- see separate mails.

Cheers
---Dave
