From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 29 May 2013 16:23:37 +0200
Subject: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ
 pin and msecure line
In-Reply-To: <87ehcpano0.fsf@linaro.org>
References: <1369423702-31501-1-git-send-email-khilman@linaro.org>
 <20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna>
 <87obc0f54r.fsf@linaro.org>
 <CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com>
 <87a9nkf3mu.fsf@linaro.org> <51A5CCA5.7000700@ti.com>
 <87ehcpano0.fsf@linaro.org>
Message-ID: <51A60F69.7050203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/29/2013 4:03 PM, Kevin Hilman wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
> [...]
>
>>>
>>> Let me respin this after some more doc reading.
>>
>> Did you re-spin it already?
>
> Yes, v2 is here.
>
> http://marc.info/?l=linux-omap&m=136944147521955&w=2
>
> It also needed a rework because the fref_clk0_out pin is also in the
> wkup section of the padconf, not core.

OK, I'll wait for the v3 then :-)

Benoit
