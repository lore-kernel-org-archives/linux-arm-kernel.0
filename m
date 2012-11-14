From: keescook@chromium.org (Kees Cook)
Date: Wed, 14 Nov 2012 11:05:42 -0800
Subject: [PATCH v5 0/4] arch/arm: support seccomp
In-Reply-To: <50A29E28.5040303@mit.edu>
References: <1352587485-18348-1-git-send-email-keescook@chromium.org>
 <50A29E28.5040303@mit.edu>
Message-ID: <CAGXu5j+a1dmu92wxct=HBok0aWphL-Vu4xwMB1XffRWgrw8Zcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 11:23 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On 11/10/2012 02:44 PM, Kees Cook wrote:
>> This adds support for seccomp BPF to ARM. When built with the seccomp
>> improvement patch waiting in linux-next ("seccomp: Make syscall skipping
>> and nr changes more consistent"), this passes the seccomp regression
>> test suite: https://github.com/redpig/seccomp
>
> I don't know if this matters much on ARM, but should something like
> https://git.kernel.org/?p=linux/kernel/git/luto/linux.git;a=commit;h=dee1ae5a05149f30baeccb4b8f68f22525ba9ca2
> be added?

Not sure -- I'll leave that up to other folks.

-Kees

-- 
Kees Cook
Chrome OS Security
