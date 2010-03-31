From: rabin@rab.in (Rabin Vincent)
Date: Wed, 31 Mar 2010 23:55:18 +0530
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
In-Reply-To: <tnxsk80r2dh.fsf@e102109-lin.cambridge.arm.com>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-7-git-send-email-rabin@rab.in>
	<tnxsk80r2dh.fsf@e102109-lin.cambridge.arm.com>
Message-ID: <20100331182518.GA30522@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 10:23:54AM +0000, Catalin Marinas wrote:
> If the ftrace_stub isn't .globl, the code compiles fine. My approach
> would be something like this:

New patch below:
