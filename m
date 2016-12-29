From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Dec 2016 16:53:04 -0200
Subject: [PATCH 1/6] ARM: mach-mx31_3ds: Remove camera support
In-Reply-To: <CAM=E1R4ExOmqn3YCjS6wVtpCS13=dAPDtT9sgYxcAgc4UreV=A@mail.gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
 <CAM=E1R4ExOmqn3YCjS6wVtpCS13=dAPDtT9sgYxcAgc4UreV=A@mail.gmail.com>
Message-ID: <CAOMZO5ABrDtGPLGCs6SMSQPWE3Ei=ezPHviaiPp3J=vGREXrGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 4:44 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> So we keep the init of the other CSI pins bit not the power down and
> reset? Can / should the other CSI pins also be removed?

Yes, I will remove CSI pins in v2.

> I've run-time tested the patch on the i.MX31 PDK board now and it works.

Thanks for testing.
