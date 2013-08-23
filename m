From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 23 Aug 2013 09:47:44 -0700
Subject: [GIT PULL 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <20130823101114.GM6617@n2100.arm.linux.org.uk>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-2-git-send-email-shawn.guo@linaro.org>
 <87li3tvnj8.fsf@linaro.org>
 <20130823101114.GM6617@n2100.arm.linux.org.uk>
Message-ID: <CAGa+x85rvPTh3NyhY6rEtBN77gq6zVAW_TvT8k_fg9JbZGtJOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 3:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Aug 22, 2013 at 06:54:35AM -0700, Kevin Hilman wrote:
>> This patch causes a conflict with Russell's DEBUG_LL cleanup, which is
>> already in linux-next.
>>
>> For v3.12, I suggest you drop this patch and rework your new DEBUG_LL
>> support on top of Russell's cleanup.  Have a look at that and see if you
>> can reuse the the generic 8250 stuff added by Russell.  While there, you
>> might look at imx.S as well.
>
> I'm not sure why you think imx.S may be able to use the generic 8250
> stuff,

Only because I was lazy and didn't actually look.  I just suggested he
take a look.

> I did convert everything which I considered convertable at the time.

OK, good. I didn't realize you did all the conversions.  I thought you
did a few to set the example and wanted others to finish converting.

Thanks for the cleanup,

Kevin
