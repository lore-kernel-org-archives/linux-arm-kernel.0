From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Dec 2016 18:10:22 -0200
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <1482182934-18559-3-git-send-email-lilja.magnus@gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482182934-18559-3-git-send-email-lilja.magnus@gmail.com>
Message-ID: <CAOMZO5CmEL_gW6pXM3XDY+VR9q2MmqV5Q905PJjf0-W4jUBFbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Mon, Dec 19, 2016 at 7:28 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:
> All supported mc13xxx devices have active high interrupt outputs. Make sure
> to configure the interrupt as active high by passing the IRQF_TRIGGER_HIGH
> flag. This is required at least on the i.MX31 PDK board.
>
> Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>

What is the commit that caused the breakage in the driver? Please
specify in the commit log, add a Fixes tag and Cc: stable like
mentioned on patch 1/2.
