From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 15:58:40 +0000
Subject: [PATCH v6 4/7] arm64: introduce
 aarch64_insn_gen_{nop|branch_imm}() helper functions
In-Reply-To: <1386691433-6827-5-git-send-email-liuj97@gmail.com>
References: <1386691433-6827-1-git-send-email-liuj97@gmail.com>
 <1386691433-6827-5-git-send-email-liuj97@gmail.com>
Message-ID: <20131213155840.GJ19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 04:03:50PM +0000, Jiang Liu wrote:
> Introduce aarch64_insn_gen_{nop|branch_imm}() helper functions, which
> will be used to implement jump label on ARM64.
> 
> Signed-off-by: Jiang Liu <liuj97@gmail.com>

Looks good to me:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks!

Will
