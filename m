From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 17:12:12 +0100
Subject: [PATCHv4 00/10] ARMv8.3 pointer authentication userspace support
In-Reply-To: <20180503132031.25705-1-mark.rutland@arm.com>
References: <20180503132031.25705-1-mark.rutland@arm.com>
Message-ID: <20180704161212.GS4828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Mark,

On Thu, May 03, 2018 at 02:20:21PM +0100, Mark Rutland wrote:
> This series adds support for the ARMv8.3 pointer authentication extension,
> enabling userspace return address protection with recent versions of GCC.

As discussed off-list, I'd really like to get a feel for how we might use
this to protect the kernel before we commit to a userspace ABI, especially
given that there is some level of resource sharing with the keys.

So ideally, we'd merge this along with the support for the kernel side.
In the meantime, is it worth taking any of the ID register sanity checks
now?

Will
