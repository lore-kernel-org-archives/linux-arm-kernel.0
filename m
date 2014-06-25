From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 20:38:53 +0900
Subject: [PATCH 05/14] ARM: shmobile: Mark all SoCs in shmobile as
 CPUFreq, capable
In-Reply-To: <CAKohpokRgJt+L4pXd8j4uzOffNyxtQPdn37_aojHv02YwTsocQ@mail.gmail.com>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
 <6596e97e054647fecb016ecb7e1935aa2b7db954.1403681315.git.horms+renesas@verge.net.au>
 <CAOh2x==C1XDjxdxpE6fYk3j6gO1X7d976Kr-Gjj_-+W6xVzOsw@mail.gmail.com>
 <20140625092609.GC7496@verge.net.au>
 <CAKohpokRgJt+L4pXd8j4uzOffNyxtQPdn37_aojHv02YwTsocQ@mail.gmail.com>
Message-ID: <20140625113849.GA7205@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 03:00:08PM +0530, Viresh Kumar wrote:
> On 25 June 2014 14:56, Simon Horman <horms@verge.net.au> wrote:
> > In the case of ARCH_HAS_CPUFREQ, a subsequent patch in
> > this pull-request, "ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile",
> > removes it.
> 
> Hmm.. I fail to see why you are adding it in the first place then ?

Because it seemed to be right thing to do when the patch was written
and accepted.
