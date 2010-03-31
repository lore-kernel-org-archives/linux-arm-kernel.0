From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Jimenez)
Date: Wed, 31 Mar 2010 11:26:28 -0300
Subject: [PATCH] ARM: pcmcia: Adds nanoEngine PCMCIA support.
In-Reply-To: <20100331064707.GA11428@isilmar.linta.de>
References: <1269972879-27400-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100331064707.GA11428@isilmar.linta.de>
Message-ID: <w2ycecb6d8f1003310726lead65adcq2de9cb4b8560a034@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dominik,

On Wed, Mar 31, 2010 at 03:47, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Tue, Mar 30, 2010 at 03:14:39PM -0300, Marcelo Roberto Jimenez wrote:
>> This patch adds nanoEngine PCMCIA support, with support for two sockets.
>>
>> In order to have a fully functional pcmcia subsystem in a BSE nanoEngine board
>> you should carefully read this:
>>
>> http://cambuca.ldhs.cetuc.puc-rio.br/nanoengine/
>
> That website still talks about pcmcia-cs ... which was superseded by
> pcmciautils.

Indeed, pcmcia-cs is not needed anymore, in fact, does not work with
my setup, I am using pcmciautils now. The web site has not been
updated because it refers to the project as it was with the kernel 2.4
implementation. The link is there because there are two serious
hardware problems when implementing PCMCIA with nanoengine: one is
that it needs external logic, the other is that it is necessary to
reprogram the bogus version of the CPLD that originally came with the
nanoEngine board.

> The patch gets an
>
> ? ? ? ?Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> as I assume that Russell prefers to take it into his tree?

Thanks!

> Best,
> ? ? ? ?Dominik

Regards,
Marcelo.
