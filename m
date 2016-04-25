From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 00:12:40 +0200
Subject: [PATCH] ARM: uniphier: correct the call order of of_node_put()
In-Reply-To: <1460717309-3982-1-git-send-email-yamada.masahiro@socionext.com>
References: <1460717309-3982-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <7842430.tcmZ5p2utv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 19:48:29 Masahiro Yamada wrote:
> Put nodes after of_address_to_resource() in case the nodes might be
> released while parsing in them.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to next/soc, thanks

	Arnd
