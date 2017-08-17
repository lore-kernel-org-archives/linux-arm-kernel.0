From: cohuck@redhat.com (Cornelia Huck)
Date: Thu, 17 Aug 2017 09:37:41 +0200
Subject: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
In-Reply-To: <db11c343-d5f7-97cd-47df-ed801bad5947@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <db11c343-d5f7-97cd-47df-ed801bad5947@redhat.com>
Message-ID: <20170817093741.08e06833.cohuck@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Aug 2017 09:29:51 +0200
David Hildenbrand <david@redhat.com> wrote:

> As Alex said, doubling the size every time we run out of space could be
> done.
> 
> I clearly favor a solution that doesn't require user space changes.

+1 to both of this.
