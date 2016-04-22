From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 18:10:09 +0100
Subject: [PATCH 19/25] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <1459894127-17698-20-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-20-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160422171009.GR2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:08:41AM +0300, Yury Norov wrote:
> Here new aarch32 ptrace syscall handler is introsuced to avoid run-time
> detection of the task type.

The reason for this patch isn't clear to me. What's wrong with the
run-time detection? It's not some performance critical code.

-- 
Catalin
