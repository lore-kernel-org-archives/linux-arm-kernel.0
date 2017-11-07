From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Nov 2017 16:18:30 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.15, step 2
In-Reply-To: <20171106092623.tqvmvqhpopyu2mri@flea>
References: <20171106092623.tqvmvqhpopyu2mri@flea>
Message-ID: <CAK8P3a3dL2_oWiBi4p4CnAOa8F7ijcrKje1fRq84j7pWJpqECA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 6, 2017 at 10:26 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
>
> Here are a few commits that would be great to get in 4.15, given how
> long they've been hanging around.
>
> The first and most important one is the reintroduction of the EMAC DT
> changes after they've been reverted at the last minute in 4.13.
>
> There's a arm64 patch that crept in because the H5 and H3 share a
> common DTSI that is located in arch/arm, and merging that patch
> through the arm64 PR, especially given the pull requests that have
> already been sent, would just have generated too many conflicts.
That's all good, in particular as I've been pulling both arm32 and
arm64 changes into a shared next/dt branch. Please keep sending
them separately when you can, we'll just merge them as needed.

One small request: the text you wrote above makes a better changelog
text than what you had in the signed tag, so I ended up using your
longer description in the merge commit. Try to describe the changes
like that in the future too, giving a little more background in what you
see as important, instead of just listing lots of small items that
we can see from the list of commits.

Thanks,

      Arnd
