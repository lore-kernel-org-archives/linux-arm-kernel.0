From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 16:37:45 -0600
Subject: perf not capturing stack traces
In-Reply-To: <20150123205959.GD3073@kernel.org>
References: <20150123195128.GE26557@saruman.tx.rr.com>
 <20150123205959.GD3073@kernel.org>
Message-ID: <20150123223745.GJ26557@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:59:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 23, 2015 at 01:51:28PM -0600, Felipe Balbi escreveu:
> > I'm using v3.19-rc5 on an ARM Cortex A9 board. Unfortunately, perf is
> > not able to capture any stack traces even though I CONFIG_STACKTRACE,
> > CONFIG_FRAME_POINTER and CONFIG_ARM_UNWIND all enabled.
> > 
> > I wonder if anybody else is facing similar issues.
> 
> Did it work with a previous kernel?

haven't checked with this board. First time I tried to use perf for
anything.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/b0b612f0/attachment.sig>
