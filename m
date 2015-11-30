From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 30 Nov 2015 16:13:20 +0100
Subject: [PATCH 1/3] i2c: at91: add setting HOLD field of TWIHS_CWGR via DT
In-Reply-To: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151130151319.GM1513@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 02:47:40PM +0100, Ludovic Desroches wrote:
> From: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Add the HOLD field management. Some i2c devices need a longer data hold
> time than the one given in the i2c bus specification. Since this value
> depends on the i2c device connected to the bus, add a DT property to
> configure it: "atmel,twd-hold-cycles".

We already have "i2c-sda-hold-time-ns". Can you use that one? Sorry that
this is not obviously documented, I am working on it...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/7c3b6c21/attachment.sig>
