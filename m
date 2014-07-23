From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Jul 2014 17:02:28 +0200
Subject: [PATCH v2] cpufreq: tests: Providing cpufreq regression test
In-Reply-To: <CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <1405926154-27214-1-git-send-email-l.majewski@samsung.com>
 <CAKohpondk7Cty8MhTcjyzZW8Z0o4AVupYE0rRnG4YJf+SmDyjg@mail.gmail.com>
 <20140723093824.5e51918f@amdc2363>
 <CAKohpok++gPcNk9-E4MsFdNBy8qL7oLYvatk1EvcW1OHwroZXQ@mail.gmail.com>
Message-ID: <20140723150228.GE2856@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 02:19:54PM +0530, Viresh Kumar wrote:
> On 23 July 2014 13:08, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > Do you want to say that we have enough tests and we don't need more ?
> 
> No. We don't have any tests at all :)

Not really true. I've found bugs triggering opps using cpufreq-bench.
http://marc.info/?l=linux-pm&m=138165517321579&w=2

and i hope you learned from that experience and run this tool when
making changes to the core.

There is an old writeup of cpufreq-bench here:
https://lwn.net/Articles/339862/

and the code itself is in the mainline tree, tools/power/cpupower/bench

	Andrew
