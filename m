From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Sep 2014 14:06:11 -0300
Subject: [PATCH RFC 2/3] ARM: regulator: add Freescale MXS regulator driver
In-Reply-To: <54108939.5050208@gmx.net>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-3-git-send-email-info@lategoodbye.de>
 <20140909182211.GG3896@leverpostej>
 <540F523D.4010904@lategoodbye.de>
 <20140910141853.GA4994@leverpostej> <54108939.5050208@gmx.net>
Message-ID: <CAOMZO5CK=c+=y2BgsYRKVujgn3yRWYjOXkz0EwzBEVXDVpq0Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 2:24 PM, Stefan Wahren <wahrenst@gmx.net> wrote:

> sorry i don't have a clue. In the original code there isn't a comment about
> the reason. Currently there is no init of the vddio regulator by the kernel
> and everything works fine.
>
> @Fabio: Do you have any doubts?

I would say, just use and report whatever value comes from the
bootloader. No need to force a particular regulator  output.
