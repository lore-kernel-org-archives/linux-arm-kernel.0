From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 15:36:43 -0700
Subject: [PATCH v9 0/3] Add support for tegra2 based ventana board
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173BE19D81@HQMAIL01.nvidia.com>
References: <1318420387-6802-1-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE19D81@HQMAIL01.nvidia.com>
Message-ID: <20111012223643.GA5368@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 08:56:47AM -0700, Stephen Warren wrote:
> pdeschrijver at nvidia.com wrote at Wednesday, October 12, 2011 5:53 AM:
> > This patch set adds support for the tegra2 based ventana development board.
> > 
> > Boot tested on ventana.
> > 
> > Uses a table based approach to select the correct init function.
> > 
> > Provoke kernel warning when no suitable pinmux table can be found.
> 
> Whole series:
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Thanks for following up on my picky comments:-)

Yes, thanks Peter.

Applied to for-3.2/features. I had to do some fixups since I applied it
on top of some of Stephen's changes for gpio/pinmux, so please verify
that I did the fixups correctly.


-Olof
