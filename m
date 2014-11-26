From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 26 Nov 2014 17:46:46 +0100
Subject: [PATCH 3/7] KVM: arm: guest debug, add stub KVM_SET_GUEST_DEBUG
 ioctl
In-Reply-To: <87r3wqknrh.fsf@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-4-git-send-email-alex.bennee@linaro.org>
 <20141126143855.GC3245@hawk.usersys.redhat.com> <87r3wqknrh.fsf@linaro.org>
Message-ID: <547603F6.2010909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/11/2014 16:03, Alex Benn?e wrote:
> They also served the very useful roll of stopping checkpatch.pl bitching
> about my reluctance to remove braces from the if () { } clauses. However
> I take your point. I can certainly remove the kvm_info() statements as
> each bit of functionality is added while leaving this one to help when
> someone is bisecting and confused.

Good idea.


Paolo
