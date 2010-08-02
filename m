From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Aug 2010 08:31:38 +0100
Subject: Please remind 'WARNING: about Samsung merge window over'
In-Reply-To: <AANLkTimJvS0djVprEgCJ8k3_SYeaKc72NMNZNrRpqXHi@mail.gmail.com>
References: <003401cb3206$d68a1fc0$839e5f40$%kim@samsung.com>
	<AANLkTimJvS0djVprEgCJ8k3_SYeaKc72NMNZNrRpqXHi@mail.gmail.com>
Message-ID: <20100802073138.GB10608@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 03:24:13PM +0900, Kyungmin Park wrote:
> Absurd !!!
> 
> Did you mentioned that samsung merge window over before?
> why it's reminder mail? it's unilateral notification at this time.

It's standard Linux kernel development procedure.

The merge window is not for new code - the merge window is for code which
has already been merged by maintainers to submit it to Linus in an orderly
manner and fixup any conflicts which may occur.

New code which hasn't been reviewed by the beginning of the merge window
and which hasn't been in linux-next for a _reasonable_ amount of time
should wait until the following merge window unless there's a _very_ good
reason to make an exception.
