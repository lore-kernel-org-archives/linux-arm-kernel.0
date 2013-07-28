From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 28 Jul 2013 11:50:19 -0400
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130728153546.GB5224@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
 <2529481.u8xHuXumcd@flatron>
 <CAKON4OzReTRb5JnJE+07vNJ-uDndLfqq8ha04J7K3x=WtsZEWw@mail.gmail.com>
 <20130728153546.GB5224@netboy>
Message-ID: <CAKON4OzQ8BYuP00L6Ugt-tAteTdqqh58YuMfZCWQPirkGf9XMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 11:35 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Sun, Jul 28, 2013 at 10:09:57AM -0400, jonsmirl at gmail.com wrote:
>>
>> 3.z kernel is free to alter the schema. But it will have to supply the
>> necessary quirks needed to keep those old dtb's functioning.
>
> The quirks idea sounds okay to me, if it can really provide forward
> compatibility. In practice, I doubt anyone will really spend the
> effort to make this work. I think it would be much easier to make sure
> the bindings are "future proof" in the first place.

"furture proof" is much easier to say that it is to do. We've been
messing around with the audio bindings for three years and still don't
have a really good scheme. It is pretty easy to come up with the first
90% of a device tree. It is really hard to work out that last 10%.

You can easily get the chips into the tree. Doing that will load the
correct device drivers. But now how are these chips wired together? Is
the appropriate button, LED, etc attached to all the IO pins offered
by the chip? Those answers vary by the PCB the chip was used in..
Trying to figure out a scheme for this has lead to some volatility in
the device trees.  The whole concept of pin mapping was missing from
the early device trees.


>
> Thanks,
> Richard



-- 
Jon Smirl
jonsmirl at gmail.com
