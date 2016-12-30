From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 09:13:42 +0100
Subject: [PATCH 1/2] pinctrl: sirf: atlas7: Add missing 'of_node_put()'
In-Reply-To: <20161220054043.25417-1-christophe.jaillet@wanadoo.fr>
References: <20161220054043.25417-1-christophe.jaillet@wanadoo.fr>
Message-ID: <CACRpkdZP1E6Br=oiqxR1hOxSacUBDCkKW5dhuiXBvxrERXpx0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 6:40 AM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> Reference to 'sys2pci_np' should be dropped in all cases here, not only in
> error handling path.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied.

Yours,
Linus Walleij
