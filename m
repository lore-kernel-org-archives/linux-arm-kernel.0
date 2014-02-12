From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Feb 2014 12:04:58 -0800
Subject: [PATCH v3] ARM: tegra: cpuidle: use firmware for power down
In-Reply-To: <1392173024-11567-1-git-send-email-acourbot@nvidia.com>
References: <52FAD4C2.80803@nvidia.com>
 <1392173024-11567-1-git-send-email-acourbot@nvidia.com>
Message-ID: <CAOesGMhk_chCYJ0Qpj0Sju6k7OQJ+c1_VnfZNTOfw2WPHPyQ4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 6:43 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Attempt to invoke the prepare_idle() and do_idle() firmware calls
> to power down a CPU so an underlying firmware gets informed of
> the idle operation and performs it by itself if designed in such a way.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
