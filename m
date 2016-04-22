From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 23 Apr 2016 00:40:13 +0300
Subject: [PATCH 19/25] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <20160422171009.GR2998@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-20-git-send-email-ynorov@caviumnetworks.com>
 <20160422171009.GR2998@e104818-lin.cambridge.arm.com>
Message-ID: <20160422214013.GA2234@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 06:10:09PM +0100, Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:41AM +0300, Yury Norov wrote:
> > Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
> > detection of the task type.
> 
> The reason for this patch isn't clear to me. What's wrong with the
> run-time detection? It's not some performance critical code.
> 
> -- 
> Catalin

Hi Catalin,

It was requested by Arnd, 
It's not 'new' syscall basically,
just an attempt to avoid run-time 
detection of things that may be
detected an compile-time.

Yury.
