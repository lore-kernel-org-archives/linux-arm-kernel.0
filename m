From: davem@davemloft.net (David Miller)
Date: Sun, 17 Jan 2016 19:15:15 -0500 (EST)
Subject: [PATCH 1/2] arm64: insn: remove BUG_ON from codegen
In-Reply-To: <20160115170852.GB1641@arm.com>
References: <1452756802-16511-1-git-send-email-zlim.lnx@gmail.com>
 <20160115170852.GB1641@arm.com>
Message-ID: <20160117.191515.1256557824840537819.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>
Date: Fri, 15 Jan 2016 17:08:53 +0000

>   Acked-by: Will Deacon <will.deacon@arm.com>

Please do not indent Acked-by: tags like this, it must appear
on the very first column of the line or else automated tools
and things like patchwork will not pick it up properly.

I fixed it up by hand this time, but if you continue to do
this I may make mistakes and miss it in the future and besides
you're making more work for me.

Thanks.
