From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 1 Nov 2013 10:07:37 +0100
Subject: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu
 node in DT.
In-Reply-To: <CAKohpokTWfBnhWj+bdA9zx-+hyXUdp4ir5BYkZNLe08mcwVwLg@mail.gmail.com>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <1383247111-26834-4-git-send-email-andrew@lunn.ch>
 <1429743.Nz1AUEe5Hi@vostro.rjw.lan>
 <CAKohpokTWfBnhWj+bdA9zx-+hyXUdp4ir5BYkZNLe08mcwVwLg@mail.gmail.com>
Message-ID: <20131101090737.GB26890@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 05:21:03AM +0530, Viresh Kumar wrote:
> On 1 November 2013 03:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
> >> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
> >> is also an interrupt generated when the DFS hardware completes a
> >> change of frequencey. Add these to the cpu node in DT.
> >>
> >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >
> > I need someone with DT bindings knowledge to ACK this for me.
> 
> I can do that

Thanks.

, but this set has to be rebased over all the latest developments
> in cpufreq core before getting posted again..

I will wait for -rc1 and rebase. 

Thanks
	Andrew
