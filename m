From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Apr 2017 14:31:32 +0200
Subject: [PATCH v2] ARM: at91: Document new TCB bindings
In-Reply-To: <a8d541f0-e70a-a12d-5a7e-b1b72eddbe65@linaro.org>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160701012743.GA16698@rob-hp-laptop>
 <20160704151058.44b679bf@bbrezillon>
 <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
 <20170125161129.41acaa9a@bbrezillon>
 <fd4a2797-d8eb-ac80-36fc-01240fb0e944@atmel.com>
 <a8d541f0-e70a-a12d-5a7e-b1b72eddbe65@linaro.org>
Message-ID: <20170407123132.ety26gj7sak5lr6t@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 at 14:15:36 +0200, Daniel Lezcano wrote:
> >> What's your solution for this case?
> > 
> > It seems that we don't have any progress on this topic for more than 6
> > months which is a pity as we now experience an issue that would have
> > been addressed completely by the TC rework [1].
> > 
> > aka "ping"... ;-)
> 
> 
> Hi Nicolas, Boris,
> 
> is there any news from your side ?
> 

I'm planning to resubmit news bindings and the full rework when I'll
have time to work on that. But I must admit I don't quite see the issue
with the proposed bindings.

Also, we are starting to see more and more flexible timer IPs that can
be used as RTC, timer, pwm, counters, quad decoders. I'm starting to
think we may need a new subsystem.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
