From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 18:13:10 -0700
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <20140506110758.9ddcae1a0fa3b9548e37bc58@canb.auug.org.au>
References: <20140506110758.9ddcae1a0fa3b9548e37bc58@canb.auug.org.au>
Message-ID: <CAOesGMgLemvWtzN=eBwKerYxcVddx=Uc6O+5aLfL2Yg9GqPTBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 6:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the mvebu tree got a conflict in
> arch/arm/mach-mvebu/Kconfig between commit 55400f3a1f89 ("ARM: mvebu:
> clean-up unneeded kconfig selects") from the arm-soc tree and commit
> 8e6ac2033822 ("ARM: mvebu: enable the ARM SCU on Armada 375 and Armada
> 38x") from the mvebu tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Thanks for the heads up. This will be resolved permanently once we
merge the mvebu contents into arm-soc (since that'll go on top of the
kconfig select cleanup).


-Olof
