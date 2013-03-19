From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 19 Mar 2013 14:15:29 +0900
Subject: [PATCH v3 1/3] ARM: shmobile: sh73a0: wait for completion when
 kicking the clock
In-Reply-To: <20130319034214.GB21444@verge.net.au>
References: <1362054120-8600-1-git-send-email-g.liakhovetski@gmx.de>
 <1362054120-8600-2-git-send-email-g.liakhovetski@gmx.de>
 <20130301025222.GA32306@verge.net.au>
 <20130319034214.GB21444@verge.net.au>
Message-ID: <CANqRtoSk9PQWsU2E5b_CuO9AaE69fZ7GMzSjUz7DjjCY+Xcr2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 12:42 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Mar 01, 2013 at 11:52:25AM +0900, Simon Horman wrote:
>> On Thu, Feb 28, 2013 at 01:21:58PM +0100, Guennadi Liakhovetski wrote:
>> > To reconfigure clocks, controlled by FRQCRA and FRQCRB, a kick bit has to
>> > be set and to make sure the setting has taken effect, it has to be read
>> > back repeatedly until it is cleared by the hardware. This patch adds the
>> > waiting part, that was missing until now.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> This patch seems to be ready to be applied.
>>
>> Magnus, could I get a review from you?
>
> Magnus, ping.

Thanks for the ping. This patch looks good to me.

Acked-by: Magnus Damm <damm@opensource.se>

Now if we could do the same thing for the MSTP bits too then that
would be excellent...

/ magnus
