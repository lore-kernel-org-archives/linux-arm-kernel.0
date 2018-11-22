From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 22 Nov 2018 15:34:16 +0000
Subject: [RFC PATCH v2 00/23] KVM: arm64: Initial support for SVE guests
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <875zwpi0sn.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> This series implements basic support for allowing KVM guests to use the
> Arm Scalable Vector Extension (SVE).
>
> The patches are based on v4.19-rc5.
>
> The patches are also available on a branch for reviewer convenience. [1]
>
> This is a significant overhaul of the previous preliminary series [2],
> with the major changes outlined below, and additional minor updates in
> response to review feedback (see the individual patches for those).
>
> In the interest of getting this series out for review,
> This series is **completely untested**.

Richard is currently working on VHE support for QEMU and we already have
SVE system emulation support as of 3.1 so hopefully QEMU will be able to
test this soon (and probably shake out a few of our own bugs ;-).

> Reviewers should focus on the proposed API (but any other comments are
> of course welcome!)
<snip>

I've finished my pass for this revision. Sorry it took so long to get to
it.

--
Alex Benn?e
