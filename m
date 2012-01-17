From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 17 Jan 2012 22:00:26 +0200
Subject: [GIT PULL] adding rpmsg and remoteproc to 3.3
In-Reply-To: <CAK=WgbbZBUiQkCOd=XqT9X_KexKKPft3NB6MCPK1DXfPcqAZ2w@mail.gmail.com>
References: <CAK=WgbbZBUiQkCOd=XqT9X_KexKKPft3NB6MCPK1DXfPcqAZ2w@mail.gmail.com>
Message-ID: <CAK=WgbZV3PY=ujdLc=8t2F+XJiNfob1z8Tsz=ea77fPwHVxRjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 9:01 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Please pull:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git for-next-acked
>
> To get the remoteproc and rpmsg frameworks, and a few fixes that were
> collected after the frameworks were already merged into linux-next.
>
> (I also tried to push this as a signed tag "rpmsg-for-3.3" but
> am not sure how successful that feat really was)

git log --show-signature gives me the exact same output as git log
does (just built 1.7.9.rc1.3.gb6310 to have it), so I'm not sure about
the signature revalidation.

But I do see the tag and it looks sane, and being able to include a
merge commentary is indeed nice. And I guess the signature
revalidation isn't too important since I'm anyway using k.org.

Please let me know if there are any issues,

Thanks,
Ohad.
