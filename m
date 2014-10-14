From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 14 Oct 2014 06:24:32 -0700
Subject: ARMADA 370 - Distributed Switch Architecture (dsa) - device tree
In-Reply-To: <20141014113509.GB4019@localhost.localdomain>
References: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
 <20141013182517.GA18105@roeck-us.net>
 <20141014113509.GB4019@localhost.localdomain>
Message-ID: <543D2410.4060000@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2014 04:35 AM, Richard Cochran wrote:
> On Mon, Oct 13, 2014 at 11:25:17AM -0700, Guenter Roeck wrote:
>> On Mon, Oct 13, 2014 at 12:14:41PM +0200, post at twien.net wrote:
>>> Dear all,
>>> I have a custom board equipped with an ARMADA 370 SoC (88f6W11) and
>>> a Marvell switch chip (88e6352) (I have written a device driver for
>>> the latter).
>>
>> Hi Tormod,
>>
>> coincidentially, I have a DSA driver for 88e6352 almost ready for submitting it
>> upstream. What are your plans for your driver ? Do you plan to submit it
>> upstream ? Either case, it would be great if you could share a pointer to it
>> so we can make sure that it works for both our use cases.
>>
>> I have made my patch set available in the 'dsa' branch of
>> https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git
>> in case you are interested.
>
> I am working on a driver for the 88E6350/88E6351 (similar to 6352?),
> especially to enable the PTP functionality. It should be done in about
> four weeks.
>
> In order to move away from all of the hardcoded numbers for register
> access in the current dsa drivers, I have started to make macros for
> the various registers, bits, and fields. If you are interested, I
> could share that already...
>
Hi Richard,

Sure, that would be great.

I can not really tell if they are similar; I don't have the datasheet
for the 6350/6351. The datasheet for the 6352 covers a couple of other
switches, but not those two. The 6352 does support PTP; I can see that
much in its datasheet. You could check if my 6352 driver works for you ;-).

Thanks,
Guenter
