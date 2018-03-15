From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 22:06:29 +0100
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <20180316075629.019b6560@canb.auug.org.au>
References: <20180316075629.019b6560@canb.auug.org.au>
Message-ID: <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 9:56 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commit
>
>   9a5f4879cd8d ("ARM: dts: stih4xx: Add missing #sound-dai-cells")
>
> is missing a Signed-off-by from its committer.

Thanks for the report.

What script do you use to find those? I guess I should check for
missing signoffs as well when pulling a branch.

Patrice, I've dropped the merge now, and picked up the one
patch in it directly, with my signoff. This should fix the issue this
time, but please make sure you always sign off patches when
you apply them from the list.

        Arnd
