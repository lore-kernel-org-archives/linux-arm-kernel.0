From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 15 Dec 2012 07:27:38 +0000
Subject: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <1355481404-27695-6-git-send-email-zonque@gmail.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-6-git-send-email-zonque@gmail.com>
Message-ID: <20121215072738.882313E0C08@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Dec 2012 11:36:44 +0100, Daniel Mack <zonque@gmail.com> wrote:
> This patch adds basic DT bindings for OMAP GPMC.
> 
> The actual peripherals are instantiated from child nodes within the GPMC
> node, and the only type of device that is currently supported is NAND.
> 
> Code was added to parse the generic GPMC timing parameters and some
> documentation with examples on how to use them.
> 
> Successfully tested on an AM33xx board.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

For all patches in this series:
Acked-by: Grant Likely <grant.likely@secretlab.ca>
