From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 12:17:45 -0800
Subject: [PATCH] bus: uniphier-system-bus: revive tristate prompt
In-Reply-To: <1453557988-2874-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453557988-2874-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160201201745.GA13508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 11:06:28PM +0900, Masahiro Yamada wrote:
> At first, commit 4b7f48d395a7 ("bus: uniphier-system-bus: add UniPhier
> System Bus driver") introduced this driver as a tristate one.
> 
> Then, commit 326ea45aa827 ("bus: uniphier: allow only built-in
> driver") temporarily made it boolean in order to fix a link error
> in case it is compiled as a module.
> 
> The root cause was fixed by commit b80443c2211c ("of/platform: export
> of_default_bus_match_table").
> 
> Now this driver can really be a module.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to fixes.


-Olof
