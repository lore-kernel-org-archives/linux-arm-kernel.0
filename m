From: olof@lixom.net (Olof Johansson)
Date: Wed, 17 Apr 2013 16:47:19 -0700
Subject: linux-next: useless merges
In-Reply-To: <20130418093906.f965a1e17bcbe1be6ecfa50c@canb.auug.org.au>
References: <20130418093906.f965a1e17bcbe1be6ecfa50c@canb.auug.org.au>
Message-ID: <CAOesGMj1FBbYkByXAjOL3Op_LmpinjkKzdrjwY99QKDs8Wk-eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yeah, that's my fault. I rebuilt one of the branches and merged in the
new version which ended up being a NULL operation.

It'll go away when we rebuild for-next (we don't send our aggregated
for-next branch to Linus, just the individual branches that are part
of it).


-Olof

On Wed, Apr 17, 2013 at 4:39 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi guys,
>
> The only change in the arm-soc tree since yesterday (3035229f89dc), is to
> merge a merge that just merges two branches that were already merged into
> arm-soc some time ago!
>
> Please be a bit more careful, this just complicates the tree for no
> reason.
>
> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
