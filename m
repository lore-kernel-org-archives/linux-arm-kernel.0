From: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 02 Nov 2013 09:16:40 +1030
Subject: [PULL] symbol fix for ARM kallsyms
Message-ID: <87txfvagfj.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 12aee278b50c4a94a93fa0b4d201ae35d792c696:

  Merge branch 'akpm' (fixes from Andrew Morton) (2013-10-30 14:27:10 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git tags/fixes-for-linus

for you to fetch changes up to f6537f2f0eba4eba3354e48dbe3047db6d8b6254:

  scripts/kallsyms: filter symbols not in kernel address space (2013-11-02 09:13:02 +1030)

----------------------------------------------------------------
Last minute perf unbreakage for ARM modules; spent a day in linux-next.

----------------------------------------------------------------
Ming Lei (1):
      scripts/kallsyms: filter symbols not in kernel address space

 scripts/kallsyms.c      | 12 +++++++++++-
 scripts/link-vmlinux.sh |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)
