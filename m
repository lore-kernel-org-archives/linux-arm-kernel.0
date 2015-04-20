From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Mon, 20 Apr 2015 16:17:11 +0100
Subject: [PATCH v2 0/4] QEMU support for KVM Guest Debug on arm64
In-Reply-To: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
References: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <87egnex214.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Alex Benn?e <alex.bennee@linaro.org> writes:

> Hi,
>
> I thought I'd sent V1 to the list but apparently not. Anyway this
> patch series provides the QEMU side of guest debug support for arm64.
> I'm assuming the first patch will be dropped when a proper merge of
> the linux-headers is done once the kernel side is upstreamed.
>
> There is nothing particularly special about the implementation details
> although some of the bit-fiddling is a little fiddly.
>
> GIT Repos:
>
> The patch series is based off a recent master and can be found at:
>
> https://github.com/stsquad/qemu
> branch: kvm/guest-debug-v2
>
> The kernel patches for this series are based off a v4.0-rc6 and can be
> found at:
>
> https://git.linaro.org/people/alex.bennee/linux.git
> branch: guest-debug/4.0-rc6-v2
>
> Alex Benn?e (4):
>   linux-headers: partial sync from my kernel tree (DEV)
>   target-arm: kvm - implement software breakpoints
>   target-arm: kvm - support for single step
>   target-arm: kvm - add support for HW assisted debug
>
<snip>

The kernel side has had two rounds of review and is getting into shape.
It would be nice if I could get some review of the QEMU side for balance
;-)

-- 
Alex Benn?e
