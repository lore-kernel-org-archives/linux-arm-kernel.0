From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 22 Jan 2015 10:34:05 +0100
Subject: KVM: CONFIG_LOCK_DEP and CONFIG_LOCK_DETECTOR?
Message-ID: <1421919245.13638.50.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mario,

Your commit c64735554c0a ("KVM: arm: Add initial dirty page locking
support") is included in today's linux-next (ie, next-20150122). I
noticed because a script I use to check linux-next spotted a minor
problem with it.

This commit added a comment that mentions CONFIG_LOCK_DEP and
CONFIG_LOCK_DETECTOR. It seems CONFIG_LOCKDEP and CONFIG_LOCKUP_DETECTOR
should be used instead. Is a trivial patch to fix these typos queued
somewhere?

Thanks,


Paul Bolle
