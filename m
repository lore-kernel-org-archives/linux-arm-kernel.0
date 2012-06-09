From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jun 2012 13:38:34 +0100
Subject: [PATCH v2 0/4] syscall_trace fixes and cleanups
In-Reply-To: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
References: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120609123834.GA11168@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 04:12:17PM +0100, Will Deacon wrote:
> Hello,
> 
> This is version 2 of the patches originally posted here:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/097748.html
> 
> The only changes are that (a) two of the original patches (fixes) have
> been now been merged into mainline and (b) the remaining patches in the
> series are now rebased onto -rc1, which includes Al's work on the signal
> handling / syscall restarting path.
> 
> All comments welcome,

It may be a good idea to Cc Al on these.
