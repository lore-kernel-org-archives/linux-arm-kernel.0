From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2011 17:20:31 -0700
Subject: [PATCH v4 2/2] ARM: l2x0: Add OF based initialization
In-Reply-To: <1309984979-8847-2-git-send-email-robherring2@gmail.com>
References: <1309984979-8847-1-git-send-email-robherring2@gmail.com>
	<1309984979-8847-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAOesGMhVuOVVeZQmt3fW3uXML0Op_f3x5e=-OeECJsWeybk9Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 1:42 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This adds probing for ARM L2x0 cache controllers via device tree. Support
> includes the L210, L220, and PL310 controllers. The binding allows setting
> up cache RAM latencies and filter addresses (PL310 only).
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
