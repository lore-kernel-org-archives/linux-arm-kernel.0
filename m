From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Aug 2018 16:37:11 -0700
Subject: [GIT PULL] tee subsystem for v4.20
In-Reply-To: <20180824115545.GA4989@jax.lan>
References: <20180824115545.GA4989@jax.lan>
Message-ID: <CAOesGMikN1eAzpLMSgY+PwQ0cdgA_Vp9nU+P8BHcacLdh52-iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 4:55 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Hello arm-soc maintainers,
>
> Please pull these tee driver enhancements. There's one small fix for the
> OP-TEE driver to take DT status into account. There's also a patch
> providing a kernel only tee client interface that can be used by other
> drivers etc. Currently there's no users of this interface in the kernel
> but there seems to be some work in the pipe as some has tested it with
> out of tree patches.
>
> Thanks,
> Jens
>
> The following changes since commit 94710cac0ef4ee177a63b5227664b38c95bbf703:
>
>   Linux 4.18 (2018-08-12 13:41:04 -0700)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.20
>
> for you to fetch changes up to 25559c22cef879c5cf7119540bfe21fb379d29f3:
>
>   tee: add kernel internal client interface (2018-08-24 11:57:37 +0200)

Merged into next/drivers. Thanks!


-Olof
