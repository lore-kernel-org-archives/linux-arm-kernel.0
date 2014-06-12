From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Jun 2014 12:52:24 -0400
Subject: [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <CAJ5Y-ea6teac4xksRTxrt5bxEHpUXumgypD5PJwnn39oYxN4Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 12 June 2014 12:48, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> The current mailbox framework only supports DT based bindings.
> Add another mechanism for mailbox clients to register with mailbox
> controllers and request for specific mailbox channels. This enables
> usage of the mailbox framework on kernels with ACPI support.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/mailbox/mailbox.c          | 155 ++++++++++++++++++++++++-------------
>  include/linux/mailbox_client.h     |   3 +
>  include/linux/mailbox_controller.h |   6 ++
>  3 files changed, 112 insertions(+), 52 deletions(-)
>

Can you please try this change on your platform(s) with DT support?

Cheers,
Ashwin
