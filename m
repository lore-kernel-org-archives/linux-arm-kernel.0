From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 18 Aug 2016 09:04:47 +0200
Subject: [RFC PATCH 0/7] Add support for monitoring guest TLB operations
In-Reply-To: <878tvvtir5.fsf@e105922-lin.cambridge.arm.com>
References: <1471344312-26685-1-git-send-email-punit.agrawal@arm.com>
 <ed9ce98d-67d2-f01b-6bb0-5c5c842129a5@redhat.com>
 <87fuq3tjmv.fsf@e105922-lin.cambridge.arm.com>
 <a553745d-a527-b2ba-7cfa-f688786d5dc3@redhat.com>
 <878tvvtir5.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <93b02f65-25cd-13b0-f5ef-6b286b328aad@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/08/2016 19:20, Punit Agrawal wrote:
> > > Having the ability to monitor the usage of guest TLB invalidations in
> > > the host can be useful to diagnose performance issues on such systems.
> >
> > Are there hardware performance counters for these operations?
> 
> That would have been ideal! There are PMU events defined for TLB
> accesses and refills but unhelpfully none of them track maintenance
> operations.

I guess the patches do make sense then. :)

Paolo
