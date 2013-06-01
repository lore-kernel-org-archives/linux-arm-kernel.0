From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 22:56:15 -0700
Subject: [GIT PULL 1/5] of/pci dependency for mvebu/arm-soc (resend)
In-Reply-To: <20130528202140.GG31290@titan.lakedaemon.net>
References: <20130528202140.GG31290@titan.lakedaemon.net>
Message-ID: <20130601055615.GO5189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:21:40PM -0400, Jason Cooper wrote:
> Olof,
> 
> This is a resend of the previous PR.  For mvebu/of_pci it is the exact
> same.
> 
> 
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/of_pci-3.11
> 
> for you to fetch changes up to 4e23d3f505e8acfeac7cc33d4113fbb5a25c3090:
> 
>   of/pci: Add of_pci_parse_bus_range() function (2013-05-19 20:30:10 +0000)
> 
> ----------------------------------------------------------------
> of/pci changes for v3.11
> 
>  - parse DT ranges property
>  - add of_pci_get_devfn()
>  - add of_pci_parse_bus_range()
> 
> Note:
>  - mvebu/pcie will depend on this branch
>  - work by LinusW and possibly Arnd will depend on this branch
> 
> ----------------------------------------------------------------
> Andrew Murray (1):
>       of/pci: Provide support for parsing PCI DT ranges property
> 
> Thierry Reding (2):
>       of/pci: Add of_pci_get_devfn() function
>       of/pci: Add of_pci_parse_bus_range() function

Merged as of/pci-helpers, merged into next/cleanup since it's a very
early branch in our dependency chain.

However:

These two seem to have received Reviewed-by's from Rob Herring, but
they're not in the patch description. The review was back in April,
so well before when they were committed.

I'm pointing it out because reviewing is hard and thankless work, and one
of the few recognitions you might get is when LWN do their statistics.
This is in particular true around DT/OF stuff since it's a firehose of
patches coming in there. So please be careful to pick them up when they
come across. 

This goes for everybody, I'm not trying to single anyone out here. I also
_don't_ need a post-mortem to why they got dropped in this particular
case, please. :)


-Olof
