From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 13 Sep 2013 15:50:07 -0700
Subject: [PATCH] arm: Fix build error with context tracking calls
In-Reply-To: <20130913170331.GA8453@somewhere> (Frederic Weisbecker's message
 of "Fri, 13 Sep 2013 19:03:34 +0200")
References: <20130908090206.GK25647@n2100.arm.linux.org.uk>
 <522CB0DE.2010102@roeck-us.net>
 <20130909105115.GL25647@n2100.arm.linux.org.uk>
 <522DB86A.8010207@roeck-us.net>
 <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
 <20130909160348.GB18975@roeck-us.net>
 <20130909203141.GM25647@n2100.arm.linux.org.uk>
 <20130909210203.GC28416@roeck-us.net>
 <alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
 <87y574g1fi.fsf@linaro.org> <20130913170331.GA8453@somewhere>
Message-ID: <87mwnggwv4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker <fweisbec@gmail.com> writes:

> On Tue, Sep 10, 2013 at 08:07:45AM -0700, Kevin Hilman wrote:
>> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
>> 
>> > Adding Kevin Hilman to the CC as he might be interested as well.
>> 
>> Thanks, I'd already noticed this but was distracted getting arm-soc
>> changes ready for the merge window.  Looking into it now.
>
> Kevin, can you please try this patch? It built tested fine on ARM
> and live tested correctly on x86. There should be no problem but
> just in case.

Tested-by: Kevin Hilman <khilman@linaro.org>

Things are back to working again on ARM.  Thanks for the fix, and for
build testing on ARM.  

As you noticed to test on ARM, we still have to carry that patch to
drop that 'depends on 64BIT' in order to build/test this... any more
thoughts on what the remaining obstacles there are?

Kevin
