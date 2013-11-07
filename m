From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Thu, 7 Nov 2013 17:04:48 -0200
Subject: ARM audit, seccomp, etc are broken wrt OABI syscalls
In-Reply-To: <CAGXu5jK6Q_CZTvKo3xT9CEjJ5qyMAP2qHby1YPCg4b72aRUNBg@mail.gmail.com>
References: <CALCETrUt7Ojh5Yy4KYgBPj_wBr=fzKKJ=OOgGP9BtXoKrr9QnA@mail.gmail.com>
 <CAGXu5jJreo001uBLV8oAgR_Z2WZK2qtH8YfvriQJVAQ4SgdRzw@mail.gmail.com>
 <20131106004058.GU16735@n2100.arm.linux.org.uk>
 <CALCETrXd7SknNCptTTojBzOo+RNzPwGrgjigVdVeOkGMAtajWg@mail.gmail.com>
 <20131107125532.GB3355@khazad-dum.debian.net>
 <CAGXu5jK6Q_CZTvKo3xT9CEjJ5qyMAP2qHby1YPCg4b72aRUNBg@mail.gmail.com>
Message-ID: <20131107190448.GA14011@khazad-dum.debian.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Nov 2013, Kees Cook wrote:
> On Thu, Nov 7, 2013 at 4:55 AM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
> > On Tue, 05 Nov 2013, Andy Lutomirski wrote:
> >> Maybe the thing to do is to put a warning in the config text for
> >> CONFIG_OABI_COMPAT that describes the problems (malicious userspace
> >> can confuse syscall auditors, strace, etc.), change the "if in doubt"
> >> part to N, and disable seccomp filters if CONFIG_OABI_COMPAT.  That
> >> might even get Debian to change their default.
> >
> > Bug reported to the Debian BTS: #728975
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=728975
> 
> FWIW, Ubuntu has also now disabled OABI_COMPAT going forward:
> https://lists.ubuntu.com/archives/kernel-team/2013-November/034242.html

Unless something very weird happens, it looks like that's also what Debian
will do.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
