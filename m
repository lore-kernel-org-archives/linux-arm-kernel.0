From: ast@fb.com (Alexei Starovoitov)
Date: Sat, 19 Aug 2017 13:48:43 -0700
Subject: [PATCH net-next v3] arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdJnHxu4gJ8ZVFmrmaXyZL1oFkTbz2K___xKLQedTLmBQg@mail.gmail.com>
References: <1503134429-29063-1-git-send-email-illusionist.neo@gmail.com>
 <c2f4c796-0cb0-7eca-6cab-fed6b25020d5@fb.com>
 <CAHgaXdJnHxu4gJ8ZVFmrmaXyZL1oFkTbz2K___xKLQedTLmBQg@mail.gmail.com>
Message-ID: <9d77730f-c6a8-b337-599e-5919207a7e0a@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/19/17 12:59 PM, Shubham Bansal wrote:
> not be able to compare them like kees this week.
> Does that sound good?

yeah. that's fine. I was more interested in selftests/.../test_progs
numbers before/after, since they're more representative of real world
performance vs test_bpf.ko

> Thats right. But still an improvement I guess. I think I discussed it
> with Daniel and I thought, I should get this patch reach mainstream
> first then I can improve on it.

agree. To me the patch looks ready to land.
