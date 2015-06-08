From: jistone@redhat.com (Josh Stone)
Date: Mon, 08 Jun 2015 09:37:32 -0700
Subject: [PATCH] arm64: fix missing syscall trace exit
In-Reply-To: <20150608102104.GB1654@arm.com>
References: <20150605153816.GG7420@arm.com>
 <1433539683-29539-1-git-send-email-jistone@redhat.com>
 <20150608102104.GB1654@arm.com>
Message-ID: <5575C4CC.6070204@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 03:21 AM, Will Deacon wrote:
>> v2: Re-enable interrupts before branching to __sys_trace_return.
> 
> Please don't include the changelog in the commit message.

Ok - do you need me to resend without it?

> I assume this can wait until 4.2?

That's fine with me, thanks.
