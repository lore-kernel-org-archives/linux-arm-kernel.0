From: david@redhat.com (David Hildenbrand)
Date: Mon, 9 Jan 2017 16:05:01 +0100
Subject: [RFC 00/55] Nested Virtualization on KVM/ARM
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <7991b5fa-cbd3-a3b3-3f1c-8b8655ebdcfd@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Even though this work is not complete (see limitations below), I'd appreciate
> early feedback on this RFC. Specifically, I'm interested in:
> - Is it better to have a kernel config or to make it configurable at runtime?

x86 and s390x have a kernel module parameter (nested) that can only be
changed when loading the module and should default to false. So the
admin explicitly has to enable it. Maybe going the same path makes
sense.

-- 

David
