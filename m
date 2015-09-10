From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Sep 2015 18:02:57 +0100
Subject: [GIT PULL] arm64: updates for 4.3
In-Reply-To: <CAOZdJXX_avYXi9JSk=Ge6fuBLzS1n2jd7yBmhnFx4u_ptvNS5A@mail.gmail.com>
References: <20150904102656.GC4818@arm.com>
 <CAOZdJXX_avYXi9JSk=Ge6fuBLzS1n2jd7yBmhnFx4u_ptvNS5A@mail.gmail.com>
Message-ID: <20150910170257.GH22439@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 05:58:43PM +0100, Timur Tabi wrote:
> On Fri, Sep 4, 2015 at 5:26 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> >   * Hide direct DCC access from userspace
> 
> Doesn't this make sense only if DCC is enabled for ARM64?  These
> patches are not part of your patchset:
> 
> [v5] ARM64: TTY: hvc_dcc: Add support for ARM64 dcc
> [v3] hvc_dcc: don't ignore errors during initialization

Those patches should go via the usual route for tty changes (i.e. Greg).
I merged the arm64 change here because it (a) makes sense as a standalone
patch and (b) is a dependency for your other stuff.

Will
