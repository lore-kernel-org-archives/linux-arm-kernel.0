From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 May 2012 07:03:18 -0700
Subject: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
In-Reply-To: <20120517232755.EF4383E062C@localhost> (Grant Likely's message of
 "Thu, 17 May 2012 17:27:55 -0600")
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
 <87y5oqtpnw.fsf@ti.com> <20120517232755.EF4383E062C@localhost>
Message-ID: <87d361powp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

>> Grant, after Tarun/Santosh have a chance to review/ack this, can you
>> still get this in for 3.5?  If not, getting it into -rc should be fine.
>
> Yes.  Do you have any other omap patches?  Do you want to send me a
> pull req?

We just found one more fix needed.

I'm collecting the acks/tested-bys and will have a branch for you
shortly.

Kevin
