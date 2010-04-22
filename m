From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Thu, 22 Apr 2010 10:35:23 -0400
Subject: [PATCH] ARM: LPC32XX: Update PHY3250 MTD partition info
In-Reply-To: <0D753D10438DA54287A00B0270842697636D69B0FB@AUSP01VMBX24.collaborationhost.net>
References: <1271353494-13831-1-git-send-email-bengardiner@nanometrics.ca>
	<083DF309106F364B939360100EC290F80976AE806D@eu1rdcrdc1wx030.exi.nxp.com>
	<0D753D10438DA54287A00B0270842697636D69B0FB@AUSP01VMBX24.collaborationhost.net>
Message-ID: <i2jc35f83941004220735y9014c1dfkcea9ad4adb4e94de@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 8:35 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> On Thursday, April 15, 2010 5:18 PM, Kevin Wells wrote:
>> Hi Ben,
>>
>> Thanks for posting these. The MTD support is currently
>> only available on our GIT server, although we plan on
>> getting the MTD patches into the mtd subtree soon..
>> This partitioning scheme isn't set it stone yet. We'll look at it
>> again once we get those patches up for review.

Ok. Please consider including Linux access to the u-boot environment
(at least) and u-boot in the MTD partitions that are set in stone.

> The last two offsets could just be:
>
> ? ? ? ?.offset = MTDPART_OFS_APPEND,
>
> That way then automatically align to the next block offset. ?It's
> cleaner and will make changing the partitioning scheme easier.

Cool. Thanks for the tip, Hartley.

Regards,
Ben Gardiner

-- 
Ben Gardiner
Nanometrics Inc.
+1 (613) 592-6776 x239
http://www.nanometrics.ca
