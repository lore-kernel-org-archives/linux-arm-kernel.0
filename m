From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 14:22:24 -0700
Subject: [PATCH 1/3] ARM: mvebu: clean-up unneeded kconfig selects
In-Reply-To: <CAL_JsqLNUoa3_1SFMicgCvEPzczsdadasgJZHRRPau+n-gQ0sA@mail.gmail.com>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
 <1398195678-28787-2-git-send-email-robherring2@gmail.com>
 <20140505045529.GA16022@quad.lixom.net>
 <CAL_JsqLNUoa3_1SFMicgCvEPzczsdadasgJZHRRPau+n-gQ0sA@mail.gmail.com>
Message-ID: <20140505212224.GD29245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 09:42:43AM -0500, Rob Herring wrote:
> On Sun, May 4, 2014 at 11:55 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Tue, Apr 22, 2014 at 02:41:16PM -0500, Rob Herring wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> Multi-platform support implies all these options are already selected and
> >> individual platforms don't need to select them.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Andrew Lunn <andrew@lunn.ch>
> >> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> >> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >
> > What's this based on? It doesn't apply to 3.15-rc4.
> 
> v3.15-rc2. That's strange because there are no other changes since
> rc2. Here's a pull request instead.

Hm, I wonder if I had typoed v3.15 vs v3.14 on the base branch. Anyway:

> 
> Rob
> 
> The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:
> 
>   Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> tags/kconfig-cleanups
> 

Merged. Thanks!


-Olof
