From: davem@davemloft.net (David Miller)
Date: Wed, 15 Mar 2017 14:55:12 -0700 (PDT)
Subject: arch: arm: bpf: Converting cBPF to eBPF for arm 32 bit
In-Reply-To: <CAHgaXdJL92XRjHae2Nb9j9SerSe65=N=ErDHTQf23sdBxwthzw@mail.gmail.com>
References: <CAHgaXd+EKJ0FWaaPojsNJtgY_YpdQXu6eMEp97uOpTFAWs4qTQ@mail.gmail.com>
 <CAGXu5jLo8UvpNSQZBHjWZoO959ha6KFQxFzmg7SK44wz=R_QSg@mail.gmail.com>
 <CAHgaXdJL92XRjHae2Nb9j9SerSe65=N=ErDHTQf23sdBxwthzw@mail.gmail.com>
Message-ID: <20170315.145512.1542025976162251828.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubham Bansal <illusionist.neo@gmail.com>
Date: Wed, 15 Mar 2017 17:43:44 +0530

>> You can't truncate, but you'll have to build 64-bit ops using 32-bit registers.
> 
> A small example would help a lot.

You can simply perform 64-bit operations in C code and see what gcc
outputs for that code on this 32-bit target.
