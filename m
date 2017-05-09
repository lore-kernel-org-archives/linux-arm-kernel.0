From: davem@davemloft.net (David Miller)
Date: Tue, 09 May 2017 16:19:41 -0400 (EDT)
Subject: arch: arm: bpf: Converting cBPF to eBPF for arm 32 bit
In-Reply-To: <CAHgaXd+xb5dN90sH___RtxgSC3usnH2jXkA5r3=fQJc3pOY5xw@mail.gmail.com>
References: <CAHgaXdJ1M4W3p9=B2hJmtxByPsA5-XHae8U6YtDH_2r_XMaR5A@mail.gmail.com>
 <58E639E0.1010700@iogearbox.net>
 <CAHgaXd+xb5dN90sH___RtxgSC3usnH2jXkA5r3=fQJc3pOY5xw@mail.gmail.com>
Message-ID: <20170509.161941.675253656642957586.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubham Bansal <illusionist.neo@gmail.com>
Date: Wed, 10 May 2017 01:42:10 +0530

> Why is trying to execute TAX which is a cBPF instruction?

Because some of the tests are classic BPF programs which
get translated into eBPF ones and sent to the JIT for
compilation.
