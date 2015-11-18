From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Nov 2015 11:01:24 +0000
Subject: [PATCHv3 0/7] arm64: Use contiguous PTE bit for the kernel
 linear mapping
In-Reply-To: <564B49B4.8000204@arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
 <20151009125052.GV17192@e104818-lin.cambridge.arm.com>
 <5617D67E.8080607@arm.com> <564B49B4.8000204@arm.com>
Message-ID: <20151118110124.GF22731@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 09:37:24AM -0600, Jeremy Linton wrote:
> Hello,

Hi Jeremy,

> 	Just a heads up, but this patch is causing a boot problem on a m400. I
> should know more soon.

Any chance you could share a reproducer/panic log/debug info, please?
If we can't fix this soon, then we'll have to look at reverting the change,
so getting a few more eyes on the problem might help.

Will
