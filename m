From: msalter@redhat.com (Mark Salter)
Date: Tue, 03 Jul 2018 11:20:44 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <1530610221.9841.128.camel@debian.org>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
 <0cbc68d5-9a8f-1734-4eea-d1f037927137@infradead.org>
 <cb5aa4ee12422ecc5f6530f3a74bcfa553b42c80.camel@redhat.com>
 <a59fa0f8-4123-bcd9-670a-8885d34f37ed@arm.com>
 <0be5ce017286a4ec494e0f0969bb10126b8501ce.camel@redhat.com>
 <bd5fc825573c3394b80365ad2dc47bde7b22044a.camel@gmail.com>
 <950b3034-08a8-38b9-b8f9-514d3e2519fa@arm.com>
 <257bbf8d90669921cede5b2e7555b9523311b795.camel@redhat.com>
 <CAKv+Gu9VfK8itWr5EoOGAdSA-OkrXystw-sbooOq2ZOpFwi9vw@mail.gmail.com>
 <45b96b937687b199bdbd6966491ab23f50bb20e7.camel@redhat.com>
 <1530610221.9841.128.camel@debian.org>
Message-ID: <ff46b8ab2786eae798a9a650d24cb20ea1504fd2.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-03 at 10:30 +0100, Ian Campbell wrote:
> On Wed, 2018-06-27 at 08:25 -0400, Mark Salter wrote:
> > On Wed, 2018-06-27 at 10:48 +0200, Ard Biesheuvel wrote:
> > > On 26 June 2018 at 22:20, Mark Salter <msalter@redhat.com> wrote:
> > > > [040h 0064   8]                      Address : 0000004FF7E9F0E0
> > > > 
> > > 
> > > This is a reserved region in the memory map. Does that apply to the
> > > other occurrences as well?
> > 
> > Yes, they are all in the same reserved region.
> 
> I wonder if it corresponds to some actual peripheral on a different X-
> gene based platform (e.g. perhaps a reference design)?
> 
> Not sure what one would do with that information, just curious.
> 
> Ian.

It's a reserved region of system RAM.
