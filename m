From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Sun, 20 Aug 2017 01:32:55 +0530
Subject: [PATCH net-next v3] arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdJnHxu4gJ8ZVFmrmaXyZL1oFkTbz2K___xKLQedTLmBQg@mail.gmail.com>
References: <1503134429-29063-1-git-send-email-illusionist.neo@gmail.com>
 <c2f4c796-0cb0-7eca-6cab-fed6b25020d5@fb.com>
 <CAHgaXdJnHxu4gJ8ZVFmrmaXyZL1oFkTbz2K___xKLQedTLmBQg@mail.gmail.com>
Message-ID: <CAHgaXdKF7JFSWdDgmvne4qW=p9Tx+2=WQLwsa9i5cr0kvSb=WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing I forgot to mention.

I think this is the first implementation of eBPF JIT on any 32 bit
arch, correct me if I am wrong. I think we can use this as a POC to
implement eBPF on other 32 bit arch as well like x86, depends on its
need I guess.
