From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Jan 2017 08:15:00 -0600
Subject: [PATCH 1/4] input: Add support for the tm2 touchkey device driver
In-Reply-To: <1483430237-26823-2-git-send-email-jcsing.lee@samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075733epcas5p47dff8d21854938b2439c9843d91bc301@epcas5p4.samsung.com>
 <1483430237-26823-2-git-send-email-jcsing.lee@samsung.com>
Message-ID: <20170104141500.nhnycny3gbjp6e2l@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 04:57:14PM +0900, Jaechul Lee wrote:
> This patch adds the binding description of the tm2 touchkey
> device driver.
> 
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> ---
>  .../bindings/input/samsung,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt

Acked-by: Rob Herring <robh@kernel.org>
