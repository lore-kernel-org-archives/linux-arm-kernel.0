From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 25 Apr 2014 12:50:30 -0700
Subject: [PATCH 000/222] The *Full* Cubox-i series
In-Reply-To: <20140425141550.GQ26756@n2100.arm.linux.org.uk> (Russell King's
 message of "Fri, 25 Apr 2014 15:15:50 +0100")
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <20140425135048.GA7388@ulmo>
 <20140425141550.GQ26756@n2100.arm.linux.org.uk>
Message-ID: <7hwqedjiih.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Apr 25, 2014 at 03:50:49PM +0200, Thierry Reding wrote:
>> On Fri, Apr 25, 2014 at 12:29:51PM +0100, Russell King - ARM Linux wrote:
>> > So that people can see what kind of a patch nightmare I'm in, and
>> > hopefully start being more co-operative towards getting patches into
>> > mainline, here is the *full* patch set for CuBox-i support that I'm
>> > presently sitting on.
>> > 
>> > Anything that can be done to make this easier would be very helpful,
>> > so I'm not spending lots of time tweaking some random patch and then
>> > having to remerge all these different sub-series.
>> 
>> Do you happen to have a branch that I can pull to test this on Tegra? Is
>> there anything that I should be paying special attention to when
>> testing?
>
> One of the issues I'm _most_ concerned about is the L2C code.  I only
> have a very limited number of platforms I can test that stuff out on.
>
> The L2C code that I've now dumped into linux-next is there in an attempt
> to get more testing coverage, and it has resulted in that - Kevin's
> boot test revealed that it breaks on a Broadcom platform.  I'm hoping
> Kevin will investigate further as per my emails, but I've no idea at the
> moment whether that's going to happen or not.  

Yes, it is happening.  Actually Matt Porter (co-maintainer of BCM SoC
support) has reproduced it and is looking into it since he has access to
HW details/docs that I do not.  However, both of us will be at ELC next
week, so there might not be much progress immediately.

Kevin
