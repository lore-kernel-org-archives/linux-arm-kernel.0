From: geoff@infradead.org (Geoff Levand)
Date: Mon, 30 Sep 2013 11:41:00 -0700
Subject: kexec/kdump for arm64
Message-ID: <1380566460.9509.31.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Just for anyone who might be interested, I've started to do
some work on kexec and kdump support for arm64.  This work
is being done within Linaro, so is tracked by their Jira
system:

  https://cards.linaro.org/browse/CARD-563

I have these two git repos with my work-in-progress patches:

  https://git.linaro.org/gitweb?p=people/geoff/kexec-tools.git

  https://git.linaro.org/gitweb?p=people/geoff/linux-kexec.git

As of now, I'm just trying to get the pieces in place for a
basic kexec reboot.  Kdump and advanced features will come
later.  Comments or suggestions welcome.

-Geoff
