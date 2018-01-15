From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 15 Jan 2018 13:05:57 -0500
Subject: [RESEND PATCH 0/2] selftests: ftrace: Fix multiple-kprobe testcase
In-Reply-To: <151593777761.23875.10360397710751679883.stgit@devbox>
References: <151593777761.23875.10360397710751679883.stgit@devbox>
Message-ID: <20180115130557.34aaac4f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Shuah,

Want to take these in your tree? You can add:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Sun, 14 Jan 2018 22:49:37 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> These patches are fixing a bug and improve testcase to
> ensure adding 256 kprobe events for test.
> 
> I've just updated to the latest kselftest/master branch.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       [BUGFIX] selftest: ftrace: Fix to pick text symbols for kprobes
>       selftest: ftrace: Fix to add 256 kprobe events correctly
> 
> 
>  .../ftrace/test.d/kprobe/multiple_kprobes.tc       |   21 +++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
