From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Jimenez)
Date: Tue, 4 May 2010 15:16:40 -0300
Subject: Suspicious compilation warning
In-Reply-To: <20100504174507.GI30601@n2100.arm.linux.org.uk>
References: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>
	<20100420155122.6f2c26eb.akpm@linux-foundation.org>
	<20100420230719.GB1432@n2100.arm.linux.org.uk>
	<n2gcecb6d8f1005041035w51dac3c8ke829a4ae8bf7f408@mail.gmail.com>
	<20100504174507.GI30601@n2100.arm.linux.org.uk>
Message-ID: <v2gcecb6d8f1005041116wc521061jba732b6a10b0b3e7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 4, 2010 at 14:45, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> What should be asked is whether it has been tested - if not, can we find
> someone who can test and validate the change?

I can test it, but I need help to figure out the test itself. I am
porting the kernel 2.6 to nanoengine and my resources in that
environment are still rather limited, not to mention I have not
finished the PCI port, so I still have no network.

On the other hand, the current situation is clearly broken and your
solution can hardly be worse than having NR_SECTION_ROOTS == 0.

Regards,
Marcelo.
