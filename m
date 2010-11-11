From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Nov 2010 23:02:41 +0000
Subject: arm smp support patch
In-Reply-To: <4CDC7326.2080407@gmail.com>
References: <73a3b42c84eb2bfde0f861d1e53042cd.squirrel@www.concentris-systems.com>
	<20101111044125.GA5850@mvista.com> <4CDC4C11.7090003@gmail.com>
	<20101111224656.GA23785@n2100.arm.linux.org.uk>
	<4CDC7326.2080407@gmail.com>
Message-ID: <20101111230241.GB23785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 04:50:14PM -0600, Rob Herring wrote:
> On 11/11/2010 04:46 PM, Russell King - ARM Linux wrote:
>> Can you point out the ARM doc number/section which specifies that.
>>
>> My GIC TRM (which may be outdated) shows that although the SGI interrupt
>> (0:15) enable register is banked, it goes on to say "The distributor does
>> not provide registers for INTIDs<  16 because SGIs are always enabled".
>>
>
> Section 4.3.5:
>
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0048a/index.html

Yea, just found that... ;)
