From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Nov 2013 11:43:32 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121204704.E4487C40753@trevor.secretlab.ca>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131118150052.GC24408@sirena.org.uk> <20131119091216.GA4412@netboy>
 <20131120064056.GB5272@netboy> <20131121192136.GA16735@n2100.arm.linux.org.uk>
 <20131121204704.E4487C40753@trevor.secretlab.ca>
Message-ID: <CAHkRjk5MstjD9JFk+co8k89i8geJBmSF6uObhGdmWSe0GJHo8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2013 20:47, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, 21 Nov 2013 19:21:36 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Wed, Nov 20, 2013 at 07:40:57AM +0100, Richard Cochran wrote:
>> > Now, I never saw any proclamation or discussion about "DT is in flux"
>> > on the arm list. If I had, I surely would have complained, and loudly.
>> > AFAICT, this decision was made in rather private circles, but you talk
>> > as if this was abundantly clear. *It was not.*
>>
>> DT has been discussed several times over this year alone, which
>> included discussions about the stability of bindings.  Various
>> people in those threads (including myself) have put their views
>> forward.
>>
>> My position has been that if an interface ends up being published in a
>> -final kernel, then it is part of the ABI, because a -final kernel is
>> an end-product.  It's a final release which says "we've done the
>> development, it's finished for users use."  If it's not then it shouldn't
>> be in a -final kernel, or if it has to be there for development purposes,
>> it needs to be hidden behind a "this is in development" label.

+1

>> I've said that several times in the DT discussions and I believe
>> basically been ignored.  Frankly, I've said my bit and I've given up
>> caring.
>
> Umm. Not sure why you feel ignored. We're absolutely going for stability
> now.

What I was hoping for is a better way to enforce this by taking the
dts files out of the kernel. I think that's the point where the
bindings can become ABI. In the meantime we rely on contributors and
reviewers making sure backwards compatibility is preserved. But I
guess we'll eventually get there.

-- 
Catalin
