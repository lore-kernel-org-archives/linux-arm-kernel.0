From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Sep 2013 00:09:50 +0200
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <CAOMZO5A4rH_id25ROU_CdiOd79MhtU9J3jtFVyqeeD0R+=EuTw@mail.gmail.com>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-2-git-send-email-marex@denx.de>
 <CAOMZO5A4rH_id25ROU_CdiOd79MhtU9J3jtFVyqeeD0R+=EuTw@mail.gmail.com>
Message-ID: <201309300009.51084.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

[...]

> > + * There can even be only one instance of the MXS DCP due to the
> > + * design of Linux Crypto API.
> 
> Is this true? Usually we don't want to create a global struct.

Yeah, unfortunatelly :-(

> 
> > +
> > +/* AES 128 ECB and AES 128 CBC */
> > +static struct crypto_alg dcp_aes_algs[] = {
> > +       [0] = {
> 
> No need for explicitely add this [0]

I wanted to be explicit here, but OK.

[...]

Rest is fixed, thanks!

Best regards,
Marek Vasut
