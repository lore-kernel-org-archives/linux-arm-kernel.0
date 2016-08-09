From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 9 Aug 2016 18:45:54 +0200
Subject: [PATCH] i2c: don't print error when adding adapter fails
In-Reply-To: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Message-ID: <CAGhQ9VwJk1WZ2cB6Ag3HXfWEwe1GC-G9L2TWem+Lf5moLDx9uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2016 at 13:36, Wolfram Sang <wsa-dev@sang-engineering.com> wrote:
> Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
> adapter fails. So, drivers can skip this now.
>
> I am still undecided if I apply this as a single patch or break it out. But for
> reviewing, avoiding the patch bomb is probably a good thing.
>
> Should go via subsystem tree, I'd think.
>
> Wolfram Sang (1):
>   i2c: don't print error when adding adapter fails


For
>  drivers/i2c/busses/i2c-lpc2k.c          | 4 +---

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
