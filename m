From: james.morse@arm.com (James Morse)
Date: Thu, 30 Mar 2017 09:30:20 +0100
Subject: [PATCH v4 0/3] arm64: usercopy: Implement stack frame object
 validation
In-Reply-To: <CAGXu5jKhVzH9OB6QgGb1u0sbnFGn5J72FnzNeGo076f52Scn+A@mail.gmail.com>
References: <20170216182917.19637-1-james.morse@arm.com>
 <CAGXu5jJ9xis_X9qd-GxCM=oDDoynMrW=GZbfeOKKt_FpAuK83Q@mail.gmail.com>
 <CAGXu5jKhVzH9OB6QgGb1u0sbnFGn5J72FnzNeGo076f52Scn+A@mail.gmail.com>
Message-ID: <58DCC21C.6040705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

On 28/03/17 23:34, Kees Cook wrote:
> On Thu, Feb 16, 2017 at 4:54 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Feb 16, 2017 at 10:29 AM, James Morse <james.morse@arm.com> wrote:
>>> This version of Sahara's arch_within_stack_frames() series replaces the
>>> open-coded stack walker with a call to arm64's existing walker.

> Is this still in progress? Seemed like it was very close?

Ah, sorry, I lost track of this when it jumped between mail folders... Sahara
had comments on the last patch.

How does all this fit with Al Viro's uaccess unification tree?:
https://lkml.org/lkml/2017/3/29/61


Thanks,

James
