From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 13:45:19 +0100
Subject: [PATCH 2/5] pinctrl: sirf: add missing of_node_put
In-Reply-To: <1450715988-4770-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
 <1450715988-4770-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdag9qaAiAqdGmFm9UMxzJ+S9DBs0Br2MdeE=x8_EYx2PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 5:39 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> for_each_child_of_node performs an of_node_get on each iteration, so a
> return from the loop requires an of_node_put.
>
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):

Patch applied.

Yours,
Linus Walleij
