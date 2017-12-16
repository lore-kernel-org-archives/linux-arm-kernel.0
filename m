From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 12:01:51 -0200
Subject: [PATCH 2/9] ARM: dts: imx7-colibri: make sure multiplexed pins
 are not active
In-Reply-To: <20171206153005.6144-2-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-2-stefan@agner.ch>
Message-ID: <CAOMZO5AD6bDEMStEWY8hRG_8gh0RAD_66zboTsKd-cFkPtiLKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:29 PM, Stefan Agner <stefan@agner.ch> wrote:
> The Colibri pins PWM<A> and <D> are multiplexed on the module, make
> sure the secondary SoC pin is not active.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I haven't really understood the commit message, but this is probably
because I don't have access to the schematics.

Anyway:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
