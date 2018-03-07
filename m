From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 15:22:15 +0100
Subject: [GIT PULL] STi DT update for v4.17 round 1
In-Reply-To: <e30ac9b4-253c-106d-4ea5-604ec3eeb953@st.com>
References: <e30ac9b4-253c-106d-4ea5-604ec3eeb953@st.com>
Message-ID: <CAK8P3a0eyD-LaW4CVZuOKzuOSoksW4saNoCyJm=dJjr9i7_-MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 9:32 AM, Patrice CHOTARD <patrice.chotard@st.com> wrote:
> warn: You locally have sti-dt-for-v4.17-round1 but it does not (yet)
> warn: appear to be at
> git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> warn: Do you want to push it there, perhaps?
> warning: refname 'sti-dt-for-v4.17-round1' is ambiguous.
> STi dts update:
>
> Fix all DT dtc warnings when building with W=1
> For most of implicated node, the addition of a fake reg property
> fixes these warnings.
> For others nodes, their location in device tree
> have been updated.
>

Something went wrong with your git-request-pull command, but
I have pulled the tag tags/sti-dt-for-v4.17-round1 into branch next/dt
now, as this seems to be what you had intended to send.

      Arnd
