From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Jun 2016 08:39:36 -0500
Subject: [PATCH] mailbox: pl320: remove __raw IO
In-Reply-To: <1466588969-28051-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466588969-28051-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAL_JsqKtdC49+eZQ9g7V2RUNONth=AidZccpBsQ0-5Bk4QxihQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 4:49 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The use of __raw IO accesors is not endian safe and should be used
> sparingly. The relaxed variants should be as lightweight and also
> are endian safe.
>
> Note, this has not been run-time tested.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Rob Herring <robh@kernel.org>
