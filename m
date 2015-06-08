From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Jun 2015 17:43:10 +0100
Subject: [PATCH] arm64: fix missing syscall trace exit
In-Reply-To: <5575C4CC.6070204@redhat.com>
References: <20150605153816.GG7420@arm.com>
 <1433539683-29539-1-git-send-email-jistone@redhat.com>
 <20150608102104.GB1654@arm.com> <5575C4CC.6070204@redhat.com>
Message-ID: <20150608164310.GC31349@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 09:37:32AM -0700, Josh Stone wrote:
> On 06/08/2015 03:21 AM, Will Deacon wrote:
> >> v2: Re-enable interrupts before branching to __sys_trace_return.
> > 
> > Please don't include the changelog in the commit message.
> 
> Ok - do you need me to resend without it?

No need to. I'll edit the line out and queue the patch for 4.2.

Thanks.

-- 
Catalin
