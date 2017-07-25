From: yao.qi@arm.com (Yao Qi)
Date: Tue, 25 Jul 2017 12:32:10 +0100
Subject: [PATCH 00/11] ARMv8.3 pointer authentication userspace support
In-Reply-To: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
Message-ID: <bb507ee1-c7ba-4c73-0d0f-058c4821793c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/17 17:01, Mark Rutland wrote:
> If authentication fails, bits are set in the pointer such that it is guaranteed
> to cause a fault if used.

How does user space know the fault is caused by authentication fail?
When GDB is debugging a program, and it failed in pointer
authentication, I assume GDB only knows that the program receives signal
SIGSEGV, but how does GDB or user know why does the program get SIGSEGV?
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
