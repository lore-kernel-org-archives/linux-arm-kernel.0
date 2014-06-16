From: john.stultz@linaro.org (John Stultz)
Date: Mon, 16 Jun 2014 15:41:11 -0700
Subject: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
In-Reply-To: <CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
 <CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
Message-ID: <CALAqxLXQeYA8jt_hLrJSuWtt7j3t2iZSZjEVAX7ScODAgrmVbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 2:20 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This patch based upon my latest mmc tree and the next branch. I tried
> to apply it for 3.15, and I think you will be able resolve the
> conflict - I should be quite trivial.

No worries. I just didn't want to waste time resolving it if it was
logically dependent on some other change.

I'll give it a shot and get back to you.

thanks
-john
