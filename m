From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 16:46:21 +0100
Subject: [PATCH 6/7] mtd: nand: davinci: extend description of bindings
In-Reply-To: <1384960945-14528-7-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384960945-14528-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384960945-14528-7-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <201311201646.21435.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013, Ivan Khoronzhuk wrote:
> Extend bindings for davinci_nand driver to be more clear.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |   77 ++++++++++++++------
>  1 file changed, 54 insertions(+), 23 deletions(-)

Hi Ivan,

The changes look good to me, but please clarify in the changeset description
above whether this is a backwards-compatible change, a clarification without
semantic changes, or an incompatible change (which should be avoided).

	Arnd
