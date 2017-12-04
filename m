From: olof@lixom.net (Olof Johansson)
Date: Sun, 3 Dec 2017 19:41:30 -0800
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <20171204083256.262c4b7c@canb.auug.org.au>
References: <20171204083256.262c4b7c@canb.auug.org.au>
Message-ID: <CAOesGMh_YT1TH_c0xs614HoK8iAOoaxPofxQtmSuPa8h7HpHKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Stephen. I need to get a similar script going to catch these
things in our own tree.

Since this was a clean revert, I've redone it myself, carrying over
descriptions from the pull request and keeping attribution to Kevin.

Kevin; hope this is alright with you. We can revisit if not.


-Olof


On Sun, Dec 3, 2017 at 1:32 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commit
>
>   5f56b7f4854a ("Revert "Merge tag 'scpi-updates-4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into next/drivers"")
>
> is missing a Signed-off-by from its author or committer.
>
> Reverts are commits as well and so need an explanation of why they
> are done and Signed-off-by tags.
>
> --
> Cheers,
> Stephen Rothwell
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
