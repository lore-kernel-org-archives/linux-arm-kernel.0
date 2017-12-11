From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Dec 2017 08:53:54 +0100
Subject: [PATCH 01/20] dt-bindings: clock: Add ASPEED constants
In-Reply-To: <20171211050704.20621-2-joel@jms.id.au>
References: <20171211050704.20621-1-joel@jms.id.au>
 <20171211050704.20621-2-joel@jms.id.au>
Message-ID: <CAK8P3a38ynNdqeE_1EVMpSxgmCAsC_rAHiMfHv3rxjWwka4H+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:

> +#define ASPEED_NUM_CLKS                        35

Why is this part of the ABI? What if they ever come out with a new
chip that needs
one more clock and you can't change it?

     Arnd
