From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 13 Aug 2013 18:49:44 -0700
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <520AC1FE.1030600@zytor.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1999586.84BnWE5EUh@thinkpad> <20130731191209.GA8027@netboy>
 <1409617.9untvfnOTJ@flatron> <20130731200017.GC8027@netboy>
 <20130731201457.GA24642@n2100.arm.linux.org.uk>
 <CAKON4Ow7rE9cDj_tS7kmYN4incM+ay=BK96q-ph2JxYH3xiQzg@mail.gmail.com>
 <20130731204817.GC24642@n2100.arm.linux.org.uk>
 <CAKON4Ozfe=endqnXWkcWR2HuJ489Otpcu2QsjB0DNg6jpRgG+Q@mail.gmail.com>
 <20130802035027.GA19115@voom.redhat.com> <520AC1FE.1030600@zytor.com>
Message-ID: <520AE238.4030304@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2013 04:32 PM, H. Peter Anvin wrote:
> On 08/01/2013 08:50 PM, David Gibson wrote:
>> On Wed, Jul 31, 2013 at 05:26:47PM -0400, jonsmirl at gmail.com
>> wrote:
>>> On Wed, Jul 31, 2013 at 4:48 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>>> On Wed, Jul 31, 2013 at 04:37:36PM -0400, jonsmirl at gmail.com
>>> wrote:
>> [snip]
>>> Alternatively you may be of the belief that it is impossible to
>>> get rid of the board specific code. But x86 doesn't have any of
>>> it, why should ARM?
>>
>> Sure x86 has board specific code.  It's just that x86 basically
>> only has one board - PC.
>>
>
> That is one aspect (hardware standardization)... but it is more to it
> than that.
>
I have to deal with lots of embedded / non-PC x86 based systems. Worst one
I encountered so far was a board where the VGA memory space was re-used
for an eeprom. The upcoming next generation hardware I'll have to support
is so far off-standard that I'll probably have to define a new platform
type (similar to OLPC or CE4100).

No, it is not all PC. Not anymore. Intel has started to sell into
the embedded space, where PC compatibility is not a requirement.

Guenter
