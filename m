From: keescook@chromium.org (Kees Cook)
Date: Thu, 30 Mar 2017 12:54:54 -0700
Subject: [PATCH v4 0/3] arm64: usercopy: Implement stack frame object
 validation
In-Reply-To: <58DCC21C.6040705@arm.com>
References: <20170216182917.19637-1-james.morse@arm.com>
 <CAGXu5jJ9xis_X9qd-GxCM=oDDoynMrW=GZbfeOKKt_FpAuK83Q@mail.gmail.com>
 <CAGXu5jKhVzH9OB6QgGb1u0sbnFGn5J72FnzNeGo076f52Scn+A@mail.gmail.com>
 <58DCC21C.6040705@arm.com>
Message-ID: <CAGXu5jLE9h2+q9HN7MDGFbOtghBN5rSFvXUes=7OY4zfx0y0yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 1:30 AM, James Morse <james.morse@arm.com> wrote:
> Hi Kees,
>
> On 28/03/17 23:34, Kees Cook wrote:
>> On Thu, Feb 16, 2017 at 4:54 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Thu, Feb 16, 2017 at 10:29 AM, James Morse <james.morse@arm.com> wrote:
>>>> This version of Sahara's arch_within_stack_frames() series replaces the
>>>> open-coded stack walker with a call to arm64's existing walker.
>
>> Is this still in progress? Seemed like it was very close?
>
> Ah, sorry, I lost track of this when it jumped between mail folders... Sahara
> had comments on the last patch.
>
> How does all this fit with Al Viro's uaccess unification tree?:
> https://lkml.org/lkml/2017/3/29/61

It's orthogonal, though it results in bringing the hardened usercopy
to more architectures... (but the stack walker is still needed on a
per-arch basis).

-Kees

-- 
Kees Cook
Pixel Security
