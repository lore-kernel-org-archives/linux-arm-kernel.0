From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 24 Feb 2014 13:52:49 +0000
Subject: [PATCH] asm-generic: add sched_setattr/sched_getattr syscalls
In-Reply-To: <20140217184435.GD8361@arm.com>
References: <1391441617-21518-1-git-send-email-james.hogan@imgtec.com>
 <20140217184435.GD8361@arm.com>
Message-ID: <530B4EB1.9000907@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/14 18:44, Catalin Marinas wrote:
> On Mon, Feb 03, 2014 at 03:33:37PM +0000, James Hogan wrote:
>> Add the sched_setattr and sched_getattr syscalls to the generic syscall
>> list, which is used by the following architectures: arc, arm64, c6x,
>> hexagon, metag, openrisc, score, tile, unicore32.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch at vger.kernel.org
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
>> Cc: linux-c6x-dev at linux-c6x.org
>> Cc: Richard Kuo <rkuo@codeaurora.org>
>> Cc: linux-hexagon at vger.kernel.org
>> Cc: linux-metag at vger.kernel.org
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: linux at lists.openrisc.net
>> Cc: Chen Liqin <liqin.linux@gmail.com>
>> Cc: Lennox Wu <lennox.wu@gmail.com>
>> Cc: Chris Metcalf <cmetcalf@tilera.com>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,

FYI I've applied to my fixes branch which is included in linux-next,
I'll send Linus the pull request in a few days.

Cheers
James

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/0939184a/attachment.sig>
