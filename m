From: labbott@redhat.com (Laura Abbott)
Date: Mon, 10 Apr 2017 09:20:27 -0700
Subject: [PATCHv3 00/22] Ion clean up in preparation in moving out of
 staging
In-Reply-To: <20170408103821.GA12084@kroah.com>
References: <1491245884-15852-1-git-send-email-labbott@redhat.com>
 <20170408103821.GA12084@kroah.com>
Message-ID: <b1a52f74-a089-96c1-a6b9-5f4eb3d28f8b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2017 03:38 AM, Greg Kroah-Hartman wrote:
> On Mon, Apr 03, 2017 at 11:57:42AM -0700, Laura Abbott wrote:
>> Hi,
>>
>> This is v3 of the series to do some serious Ion cleanup in preparation for
>> moving out of staging. I didn't hear much on v2 so I'm going to assume
>> people are okay with the series as is. I know there were still some open
>> questions about moving away from /dev/ion but in the interest of small
>> steps I'd like to go ahead and merge this series assuming there are no more
>> major objections. More work can happen on top of this.
> 
> I've applied patches 3-11 as those were independant of the CMA changes.
> I'd like to take the rest, including the CMA changes, but I need an ack
> from someone dealing with the -mm tree before I can do that.
> 
> Or, if they just keep ignoring it, I guess I can take them :)
> 
> thanks,
> 
> greg k-h
> 

Thanks. I'll send out some nag e-mails asking for Acks. If I don't get
any, I'll resend the rest of the series after the 4.12 merge window.

Thanks,
Laura
