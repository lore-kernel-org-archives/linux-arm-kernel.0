From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 Jan 2011 08:52:50 -0700
Subject: RFC: Host-endian device tree format
In-Reply-To: <alpine.LFD.2.00.1101191031481.8580@xanadu.home>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
	<AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
	<alpine.LFD.2.00.1101191031481.8580@xanadu.home>
Message-ID: <AANLkTi==KLWXAv79u32ioQ9eSr7JEii7fW93WPPNdAez@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 8:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 19 Jan 2011, Dave Martin wrote:
>> On Wed, Jan 19, 2011 at 1:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> > The dtb isn't so much bigendian as it is network byte order.
>>
>> (For me, "network byte order" is a euphemism ... <insert
>> unconstructive rant here>)
>
> I concur.

meh. it's all about conventions.  When talking about external data, it
is far more important for everyone to agree on the same representation
than it is to tailor to each platforms preferences.  That said, rant
away!  I love a good tangent.

>> However I digress... it sounds like you are familiar with the
>> arguments I would make, and I'm not trying to get into an endianness
>> war ;)
>
> I think this is the same issue as for filesystems. ?Having different
> endianness in use might only lead to confusion when a piece of data can
> be externally provided.

exactly.

> ?And since DT was created on PPC first then that
> naturally decided on the endianness for it.

SPARC, actually, for the device tree data (via OpenFirmware), but the
dtb representation was indeed a powerpc invention.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
