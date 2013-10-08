From: horms@verge.net.au (Simon Horman)
Date: Tue, 8 Oct 2013 14:21:57 +0900
Subject: [GIT PULL 0/8] Renesas ARM based SoC updates for v3.13
In-Reply-To: <20131007182245.GE17592@quad.lixom.net>
References: <cover.1380530437.git.horms+renesas@verge.net.au>
 <20131007182245.GE17592@quad.lixom.net>
Message-ID: <20131008052154.GA1891@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 11:22:45AM -0700, Olof Johansson wrote:
> On Tue, Oct 01, 2013 at 11:34:09AM +0900, Simon Horman wrote:
> > Hi Kevin, Olof and Arnd,
> > 
> > please consider these Renesas ARM based SoC updates for v3.13.
> > 
> > This pull-request is based on v3.12-rc1.
> > 
> > 
> > The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
> > 
> >   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc
> 
> Pulled. As discussed earlier, the new platforms for 3.13 should be
> the last ones of the legacy kind; from here on out we should see
> multi-platform enabled new platforms from day one (i.e. once CCF and
> other pieces land).

Thanks.

We have one more new platform queued up for v3.13,
the r7s72100 SoC / Genmai board. I plan to send a pull requests
which includes code for that platform in the next day or so.
