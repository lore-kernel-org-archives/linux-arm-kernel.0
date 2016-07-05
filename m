From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jul 2016 18:49:21 +0100
Subject: [PATCH v4 3/3] Revert "arm64: hibernate: Refuse to hibernate if
 the boot cpu is offline"
In-Reply-To: <1467643950-11034-4-git-send-email-james.morse@arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
 <1467643950-11034-4-git-send-email-james.morse@arm.com>
Message-ID: <20160705174921.GL3565@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 03:52:30PM +0100, James Morse wrote:
> Now that we use the MPIDR to resume on the same CPU that we hibernated on,
> we no longer need to refuse to hibernate if the boot cpu is offline. (Which
> we can't possibly know if kexec causes logical CPUs to be renumbered).
> 
> This reverts commit 1fe492ce6482b77807b25d29690a48c46456beee.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
