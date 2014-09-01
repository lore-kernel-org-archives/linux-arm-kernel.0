From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 Sep 2014 21:47:38 +0800
Subject: [linux-sunxi] [PATCH v2 0/4] input: Add new sun4i-lradc-keys
 driver
In-Reply-To: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
References: <1388656707-16181-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66VZqpHyghs5xn=RdDUVU=2PxFw5BJ-R5Xpsk-nfoDM0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

It seems this series didn't get any attention. Care to respin on top
of the latest tree?

FYI, I have the series rebased on top of sunxi-next:
https://github.com/wens/linux/commits/others/sunxi-lradc-input-v2

ChenYu

On Thu, Jan 2, 2014 at 5:58 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Dimitri et al,
>
> Here is v2 of the sun4i-lradc-keys driver, changes since v1:
>
> - Use include/dt-bindings/input/input.h
> - Rename the keycodes property to linux,chan0-keycodes
>
> Regards,
>
> Hans
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/groups/opt_out.
