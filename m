From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 7 Jan 2016 11:07:41 +0100
Subject: [PULL] KVM/ARM updates for 4.5
In-Reply-To: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
References: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <568E38ED.2080904@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/12/2015 12:12, Marc Zyngier wrote:
> Hi Paolo,
> 
> THis is the first pull request for the 4.5 merge window. Not much in
> terms of features, but a rewrite of our 64bit world switch, making it
> a lot nicer, maintainable, and much more likely to cope with things
> like VHE. Also support 16bit VMIDs for systems that need to run that
> many VMs concurrently.
> 
> I was really hoping that the PMU code would make it this time around,
> but it got slightly delayed, and the holiday season didn't help. If
> we're lucky enough (read: if all known issues have been addressed), I
> may send you another pull request early in the new year.
> 
> In the mean time, please pull!

Pulled, thanks.

Paolo
