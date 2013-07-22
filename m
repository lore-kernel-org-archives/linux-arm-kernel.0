From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 22 Jul 2013 19:34:10 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <alpine.LFD.2.03.1307221428050.15022@syhkavp.arg>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
 <51E92DE5.6090404@codethink.co.uk>
 <20130719123249.GE24642@n2100.arm.linux.org.uk>
 <51E93CD0.3040302@codethink.co.uk>
 <alpine.LFD.2.03.1307221428050.15022@syhkavp.arg>
Message-ID: <51ED7B22.9040104@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/13 19:31, Nicolas Pitre wrote:
> On Fri, 19 Jul 2013, Ben Dooks wrote:
>> On 19/07/13 13:32, Russell King - ARM Linux wrote:
>>> If you value your soul, NEVER EVER EVER place stuff which is not part
>>> of the user API in a header file in a UAPI subdirectory.  And never
>>> modify a header file in a UAPI subdirectory without first having a
>>> good long think about how that modification may impact _userspace_.
>>
>> Sorry, searched for byteorder.h and just did not notice.
>>
>> Where is the best place for these to go?
>
> You should really have a look at arch/arm/include/asm/opcodes.h.

Yes, re-worked using <asm/opcodes.h> thanks.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
