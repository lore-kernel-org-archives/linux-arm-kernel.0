From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Jul 2018 17:53:08 +0100
Subject: [PATCH v2 0/3] Support rseq on arm64
In-Reply-To: <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
Message-ID: <20180709165307.GB4689@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 12:06:22PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon at arm.com wrote:
> 
> > Hello,
> > 
> > This is version two of the patches previously posted here:
> > 
> > http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon at arm.com
> > 
> > Changes since v1 include:
> > 
> >  * Move abort handler in-line to avoid possibility of it being
> >    out-of-range for conditional branch instructions
> > 
> > I've tested both native and compat (little-endian only) with the selftests
> > and they pass successfully on my Seattle box.
> 
> For the whole series:
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks, Mathieu! Are you ok with me taking this via the arm64 tree for
4.19 once I have an Ack for the asm-generic change, or would you rather
this went via somewhere else?

Cheers,

Will
