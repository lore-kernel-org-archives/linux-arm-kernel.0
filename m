From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 13 Jan 2015 08:06:05 +1300
Subject: Linux 3.19-rc3
In-Reply-To: <20150112124256.GB13360@arm.com>
References: <20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
 <54AFE53A.4020004@redhat.com> <20150109175702.GA27787@leverpostej>
 <54B01FF0.3020900@arm.com> <20150109194333.GA23028@arm.com>
 <54B09CA3.1060501@redhat.com>
 <CA+55aFw3aGeiWOiKxQaC23VVX_Q9B0cDeZc37vVfK+SJVjGwFw@mail.gmail.com>
 <20150110133742.GA6999@arm.com>
 <CA+55aFxBA6F4Kr89iZwPPeBnkiRO4GnrbUSd0CqVG-LD6ZQyiw@mail.gmail.com>
 <20150112124256.GB13360@arm.com>
Message-ID: <CA+55aFxD63S0PE4zBnEw2jn3pPSALO0BdxY7tP++8wKVdRKJ5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 1:42 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> Linus: this moves the tlb->end check back into tlb_flush_mmu_tlbonly.
> How much do you hate that?

So I'm ok with it, as long as we don't have a performance regression.

Your "don't bother freeing when the batch is empty" should hopefully
be fine. Dave, does that work for your case?

           Linus
