From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Wed, 31 Mar 2010 08:47:07 +0200
Subject: [PATCH] ARM: pcmcia: Adds nanoEngine PCMCIA support.
In-Reply-To: <1269972879-27400-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
References: <1269972879-27400-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
Message-ID: <20100331064707.GA11428@isilmar.linta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 30, 2010 at 03:14:39PM -0300, Marcelo Roberto Jimenez wrote:
> This patch adds nanoEngine PCMCIA support, with support for two sockets.
> 
> In order to have a fully functional pcmcia subsystem in a BSE nanoEngine board
> you should carefully read this:
> 
> http://cambuca.ldhs.cetuc.puc-rio.br/nanoengine/

That website still talks about pcmcia-cs ... which was superseded by
pcmciautils.

The patch gets an

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

as I assume that Russell prefers to take it into his tree?

Best,
	Dominik
