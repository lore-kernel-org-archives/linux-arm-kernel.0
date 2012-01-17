From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jan 2012 16:00:49 -0200
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <201201171849.07655.marek.vasut@gmail.com>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <201201171849.07655.marek.vasut@gmail.com>
Message-ID: <CAOMZO5DCm28u-H4S13NCCTvHpRHUkus3KoEqANsQpQ=eDpavcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/12, Marek Vasut <marek.vasut@gmail.com> wrote:

> Can you really do this in one swipe ? Or do you need to actually do one
> register
> write to ungate and another to do the configuration?

Yes, I can combine the CLKGATE and DIV field clearing operations.

Just sent v2 based on your suggestion.

Thanks,

Fabio Estevam
