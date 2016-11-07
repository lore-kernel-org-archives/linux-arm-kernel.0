From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Nov 2016 13:16:33 -0800
Subject: [PATCH] ARM: spear: Fix error handling
In-Reply-To: <20161029135839.6388-1-christophe.jaillet@wanadoo.fr>
References: <20161029135839.6388-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161107211633.GA2106@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 03:58:39PM +0200, Christophe JAILLET wrote:
> 'clk_get_sys()' returns an error pointer in case of error, not NULL. So
> test it with IS_ERR.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to fixes-non-critical, thanks.


-Olof
