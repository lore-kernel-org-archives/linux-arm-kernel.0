From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:48:36 -0700
Subject: [GIT PULL 0/7] ARM: SoC changes for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <CAOesGMj_Gk8gcbBojzCwGbT6nufNdm0ocH62vVyjh_aMEBsfQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 5:07 PM, Olof Johansson <olof@lixom.net> wrote:

> We've been able to keep conflicts down this cycle, only a few and none
> are hairy. I've described them in the affected pull requests.

Grmbl, I just fetched your tree and looked for new conflicts, and it
looks like a few more have crept in and diffstats are likely off from
the ones in my pull requests. Sorry about that.

New conflicts:

drivers/clk/ti/Makefike: Looks like an add/remove conflict on nearby
lines due to our addition of clk-814x.

drivers/pci/host/Kconfig: Bjorn and I picked up different versions of
the same fix for a problem that surfaced through the new arm64
dependencies. Go with Bjorn's.

drivers/pci/host/pci-iproc.c: Looks like whitespace delta on nearby changes.


-Olof
