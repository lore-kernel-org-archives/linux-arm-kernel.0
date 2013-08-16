From: holger@freyther.de (Holger Hans Peter Freyther)
Date: Fri, 16 Aug 2013 12:10:13 +0200
Subject: [PATCH] ARM: davinci: nand: specify ecc strength
In-Reply-To: <1376647647-13681-1-git-send-email-nsekhar@ti.com>
References: <1376647647-13681-1-git-send-email-nsekhar@ti.com>
Message-ID: <20130816101013.GY22539@xiaoyu.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 03:37:27PM +0530, Sekhar Nori wrote:
> Starting with kernel v3.5, it is mandatory
> to specify ECC strength when using hardware
> ECC. Without this, kernel panics with a warning
> of the sort:

Ah thanks, it was on my todolist. :)

holger
