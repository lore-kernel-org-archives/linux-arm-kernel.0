From: leon@leon.nu (Leon Romanovsky)
Date: Mon, 16 Jan 2012 13:31:50 +0200
Subject: [PATCH v2] [INCREMENTAL] Input: tegra-kbc - add device tree
 support
In-Reply-To: <1325639956-27502-1-git-send-email-olof@lixom.net>
References: <1325639956-27502-1-git-send-email-olof@lixom.net>
Message-ID: <CALq1K=LShfkwyfx+G3rqp9OdHzRoZzXremr2tH7guJTLZaqbRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 03:19, Olof Johansson <olof@lixom.net> wrote:
>
> This is an incremental patch updating to the revised bindings for matrix keyboards.
>
> This includes an optional "linux,fn-keymap" binding that is not yet implemented,
> that will be used to specify the Fn-key modifier layout if needed.
>
> New for v2:
> * Removed references to "matrix-keyboard-controller" compatible values
> * Rebased to be incremental on top of previous patch.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> ---
>
> Dmitry,
>
> Here's an incremental patch to go on top of your next branch.
>
> Regards,
>
> -Olof
> ---
> ?.../devicetree/bindings/input/tegra-kbc.txt ? ? ? ?| ? 17 ++++++++++-----
> ?drivers/input/keyboard/tegra-kbc.c ? ? ? ? ? ? ? ? | ? 21 +++++++++++++++----
> ?2 files changed, 27 insertions(+), 11 deletions(-)

For any reasons this patch is missing from for-next branch and the
absence of the lines below prevents from linux-next-20120116 build
(and previous too).
> + ? ? ? u32 prop;
> + ? ? ? int i;

http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=blob;f=drivers/input/keyboard/tegra-kbc.c;h=a136e2e832beff1e740c8c9a79ad850b01fe14c2;hb=refs/heads/stable#l589

--
Leon Romanovsky | Independent Linux Consultant
? ? ? ??www.leon.nu?| leon at leon.nu
