From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 09:39:20 -0600
Subject: [PATCH RESEND 4/5] mtd: nand: atmel: Document the new DT bindings
In-Reply-To: <1485535324-28393-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1485535324-28393-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485535324-28393-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170201153920.g26erfzxnxrmsu4z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 05:42:03PM +0100, Boris Brezillon wrote:
> Document the new DT bindings for the Atmel NAND controller and
> deprecate the old ones.

Why?

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/atmel-nand.txt         | 106 ++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 1 deletion(-)
