From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Apr 2012 13:41:23 -0700
Subject: [PATCH-V4 1/4] ARM: OMAP3+: am33xx: Add voltage domain data
In-Reply-To: <alpine.DEB.2.00.1204271838090.10308@utopia.booyaka.com> (Paul
 Walmsley's message of "Fri, 27 Apr 2012 18:39:07 -0600 (MDT)")
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <1333123435-27186-2-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204271838090.10308@utopia.booyaka.com>
Message-ID: <87r4v5t0jw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Vaibhav, Kevin,
>
> On Fri, 30 Mar 2012, Vaibhav Hiremath wrote:
>
>> Currently dummy voltage domain data is being created
>> in order to succeed boot process, nothing has been done
>> w.r.t actual hardware (voltage control).
>> 
>> Also, hook up the AM33XX voltage domain to OMAP framework.
>> 
>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>
> Looks okay to me.  Kevin, you want to ack this one and I will queue it?  
> Either that, or if you want to take it, I will ack it.

You can take it with the others.

Acked-by: Kevin Hilman <khilman@ti.com>
