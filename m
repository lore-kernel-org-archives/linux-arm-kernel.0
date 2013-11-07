From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Thu, 7 Nov 2013 10:55:32 -0200
Subject: ARM audit, seccomp, etc are broken wrt OABI syscalls
In-Reply-To: <CALCETrXd7SknNCptTTojBzOo+RNzPwGrgjigVdVeOkGMAtajWg@mail.gmail.com>
References: <CALCETrUt7Ojh5Yy4KYgBPj_wBr=fzKKJ=OOgGP9BtXoKrr9QnA@mail.gmail.com>
 <CAGXu5jJreo001uBLV8oAgR_Z2WZK2qtH8YfvriQJVAQ4SgdRzw@mail.gmail.com>
 <20131106004058.GU16735@n2100.arm.linux.org.uk>
 <CALCETrXd7SknNCptTTojBzOo+RNzPwGrgjigVdVeOkGMAtajWg@mail.gmail.com>
Message-ID: <20131107125532.GB3355@khazad-dum.debian.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Nov 2013, Andy Lutomirski wrote:
> Maybe the thing to do is to put a warning in the config text for
> CONFIG_OABI_COMPAT that describes the problems (malicious userspace
> can confuse syscall auditors, strace, etc.), change the "if in doubt"
> part to N, and disable seccomp filters if CONFIG_OABI_COMPAT.  That
> might even get Debian to change their default.

Bug reported to the Debian BTS: #728975
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=728975

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
