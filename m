From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Sep 2012 10:02:40 -0700
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
In-Reply-To: <20120924192154.2aab0ae61dea89722bbcb974@canb.auug.org.au>
References: <20120924192154.2aab0ae61dea89722bbcb974@canb.auug.org.au>
Message-ID: <CAOesGMgP0rSXBruLNtqfOEzPAbRdbfOmEa4K+qZ++4GzZ4yNXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 24, 2012 at 2:21 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-shmobile/include/mach/common.h between commit 35f2b0bd5911
> ("ARM: shmobile: Move definition of shmobile_init_late() to header") from
> the pm tree and commit a62580e58065 ("ARM: SoC: convert shmobile SMP to
> SMP operations") from the arm-soc tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Hmm.

Rafael, the shmobile SoC-specific code in your tree looks like it
should have been merged through arm-soc? That way we could have
resolved the conflicts locally without having it spill out into other
trees (and thus seen by both sfr and Linus when the branches goes up
to him).


-Olof
