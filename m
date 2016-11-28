From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 28 Nov 2016 14:09:26 +0000
Subject: [Qemu-devel] [kvm-unit-tests PATCH v7 00/11] QEMU MTTCG Test cases
In-Reply-To: <20161128140705.caqpoiuvxy3mg2zk@kamzik.brq.redhat.com>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
 <20161128103744.s3wq53xzsxvu5uus@kamzik.brq.redhat.com>
 <878ts3uac6.fsf@linaro.org>
 <CAFEAcA9JUOHnJL59EuhQ_dEWjt+YjEcu8LGiJ3CSk_7R4J5Efg@mail.gmail.com>
 <20161128115824.hrofgivt2mlfk7fh@kamzik.brq.redhat.com>
 <CAFEAcA8-3qHnp1T4bAiUL3NT8fHWik7-8zruyQKGgfADn5xF9w@mail.gmail.com>
 <20161128140445.j336ksd7vqhi4ivz@kamzik.brq.redhat.com>
 <20161128140705.caqpoiuvxy3mg2zk@kamzik.brq.redhat.com>
Message-ID: <CAFEAcA9WBbYeOeWfAt9dtosW=n+Zi1waF0EtckeoJHs7FsjGOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2016 at 14:07, Andrew Jones <drjones@redhat.com> wrote:
> Er... actually mach-virt is 123, as we only allocate 123 redistributors.

Oh yes, I'd forgotten about that limit. We'd need to add
a KVM API for allocating redistributors in non-contiguous
bits of memory if we wanted to raise that.

thanks
-- PMM
