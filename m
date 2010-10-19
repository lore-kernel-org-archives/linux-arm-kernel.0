From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 19 Oct 2010 16:51:20 -0700 (PDT)
Subject: [patch 9/9] efikamx: add reset
In-Reply-To: <20101019205302.732795854@rtp-net.org>
Message-ID: <636242.78053.qm@web51007.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

--- On Tue, 10/19/10, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
...
> +void mx51_efikamx_reset(int mode, const char *cmd)
> +{
> +??? if (system_rev == 0x11)
> +??? ???

Couldn't it be void mx51_efikamx_reset(void) instead?

'mode' and 'cmd' are not being used.

Regards,

Fabio Estevam


      
