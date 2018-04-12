From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 11 Apr 2018 18:45:02 -0700
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180412013435.GA21219@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
Message-ID: <CA+55aFyzwzSH-fh9M1JLduq6dZXZZ9ZsyHUgJGSDeFZVy5_vtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 6:34 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> There is a clear pattern of sneaking in ABI changes using innocently
> looking commit messages.

Yes, this siginfo stuff has been a mess.

Eric - this needs to stop. Or we need to revert all that garbage entirely.

Send a fix. And stop changing the siginfo layout or field values.

                 Linus
