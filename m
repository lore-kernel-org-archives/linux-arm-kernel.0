From: panand@redhat.com (Pratyush Anand)
Date: Mon, 15 Aug 2016 18:26:26 +0530
Subject: [PATCH 3/4] arm64: kprobes: WARN if attempting to step with
 PSTATE.D=1
In-Reply-To: <20160812124656.GA23836@localhost.localdomain>
References: <1468937260-23988-1-git-send-email-will.deacon@arm.com>
 <1468937260-23988-3-git-send-email-will.deacon@arm.com>
 <CAHB_Guonf6qc-yCr2oKDZgX+5q7qXJpSpLU3qafChrBkBqk7FA@mail.gmail.com>
 <20160809124832.GI27508@arm.com>
 <20160810080114.GB27500@localhost.localdomain>
 <20160810210401.e2bb53d1c9def874ba270f16@kernel.org>
 <20160812124656.GA23836@localhost.localdomain>
Message-ID: <20160815125626.GA28649@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2016:06:16:56 PM, Pratyush Anand wrote:
> On 10/08/2016:09:04:01 PM, Masami Hiramatsu wrote:
> > Could you also test it by using ftrace kprobe-trace interface and if you find
> > any place where can cause infinit recursion, please put the function in blacklist.
> 
> OK, Will do.

Sorry, I do not think that we can test with kprobe over ftrace in arm64. It is
yet to be supported.

~Pratyush
