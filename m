From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Oct 2017 09:49:53 +0000
Subject: [PATCH v3 0/12] arm+arm64: vdso unification to lib/vdso/
In-Reply-To: <20171030214434.ta26ekbg7jyws2lf@salmiak>
References: <20171027222353.56875-1-salyzyn@android.com>
 <20171030141813.nozm5bgumb5qp2ol@lakrids.cambridge.arm.com>
 <6c9aa942-bfc0-4c54-888a-85fd1d43e40c@android.com>
 <20171030214434.ta26ekbg7jyws2lf@salmiak>
Message-ID: <20171031094953.GA5584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 09:44:35PM +0000, Mark Rutland wrote:
> On Mon, Oct 30, 2017 at 01:34:13PM -0700, Mark Salyzyn wrote:
> > On 10/30/2017 07:18 AM, Mark Rutland wrote:
> > > On Fri, Oct 27, 2017 at 03:23:48PM -0700, Mark Salyzyn wrote:
> > > > Note I noticed a bug in the old implementation of __kernel_clock_getres;
> > > > it was checking only the lower 32bits of the pointer; this would work
> > > > for most cases but could fail in a few.
> > > Sorry if this is a stupid question, but do you mean from a prior version
> > > of this series, or the one in the kernel today?
> > 
> > apinski at cavium.com noticed this as part of the existing upstream arm64
> > assembler when he did the original conversion to C.
> 
> Just to check, does the below address the issue, or is there something that
> I've missed?

Looks fine to me. Applied.

Will
