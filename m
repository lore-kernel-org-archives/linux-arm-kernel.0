From: ast@plumgrid.com (Alexei Starovoitov)
Date: Thu, 30 Apr 2015 10:17:10 -0700
Subject: [PATCH 0/4] Seccomp filter JIT support on ARM.
In-Reply-To: <55422564.2030106@iogearbox.net>
References: <1430314657-2552-1-git-send-email-nschichan@freebox.fr>
 <554108CC.6000801@iogearbox.net> <55422193.9010905@freebox.fr>
 <55422564.2030106@iogearbox.net>
Message-ID: <55426396.6090304@plumgrid.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/30/15 5:51 AM, Daniel Borkmann wrote:
>
> If there are some additional tests that are not yet covered by
> lib/test_bpf.c,
> I'd be happy if you could add them there. This can also be as a follow-up,
> but if we can increase coverage for others as well, the better.

btw, Michael have been working on adding 173 new tests to test_bpf.
Michael, could you submit them to net-next ?
