From: post@hendrik-sattler.de (Hendrik Sattler)
Date: Tue, 23 Mar 2010 09:30:09 +0100
Subject: [PATCH] USB: gadget: pxa25x: support additional IXP425 steppings
In-Reply-To: <7FC3F153-EB1C-42AC-A5D7-119BCCB8C237@workware.net.au>
References: <7FC3F153-EB1C-42AC-A5D7-119BCCB8C237@workware.net.au>
Message-ID: <20100323093009.ms6zgeh5w44k40g4@v1539.ncsrv.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zitat von Steve Bennett <steveb@workware.net.au>:

> Here is a trivial patch to add support pxa25x_udc for additional IXP
> steppings.
>
> Please let me know if I should send this anywhere else/instead.

Your patch really is not the right approach.

I had a similar patch some time ago[1]. This driver part should  
actually be reworked to not use that ifdef and switch-case thing (and  
not read the cpu id register itself, either).

[1]: http://www.spinics.net/lists/arm-kernel/msg62009.html

I am not up-to-date how far Russell got with his proposed changes.

HS
