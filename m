From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2018 23:32:09 +0200
Subject: [PATCH v2 2/3] asm-generic: unistd.h: Wire up sys_rseq
In-Reply-To: <20180710175337.GD10177@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1531145985-3747-3-git-send-email-will.deacon@arm.com>
 <20180710175337.GD10177@arm.com>
Message-ID: <CAK8P3a2oz0o+gi4W7OhU-2_55Kfk35MuHzhv+CgGAEWtWKF=0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 7:53 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Arnd,
>
> On Mon, Jul 09, 2018 at 03:19:44PM +0100, Will Deacon wrote:
>> The new rseq call arrived in 4.18-rc1, so provide it in the asm-generic
>> unistd.h for architectures such as arm64.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> ---
>>  include/uapi/asm-generic/unistd.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Please can you Ack this, so I can take it the arm64 tree?

I just checked again that this syscall is compatible with
compat mode on all architectures that need it, so the
addition is safe.

Acked-by: Arnd Bergmann <arnd@arndb.de>
