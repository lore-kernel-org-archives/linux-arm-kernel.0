From: ast@plumgrid.com (Alexei Starovoitov)
Date: Tue, 26 Aug 2014 18:45:06 -0700
Subject: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
In-Reply-To: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
Message-ID: <CAMEtUuwZPn+hY6BTz6jj+TJHFWjhyOVFZGj_Brw9DE9YjiTbrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 6:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> This applies to:
>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>>
>> Gitweb:
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>
> Hi all-
>
> AFAIK the only thing that's changed since I submitted it is that the
> 3.17 merge window is closed.  Kees rebased the tree this applies to,
> but I think the patches all still apply.  What, if anything, do I need
> to do to help this along for 3.18?
>

+1
I think it's not just an optimization of seccomp path, but I feel
in the future it will help me speedup syscall tracepoints which
are quite slow right now comparing to kprobes...
