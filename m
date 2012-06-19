From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 22:32:03 -0300
Subject: [PATCH] ARM: imx23-evk.dts: Fix total RAM size
In-Reply-To: <20120619011737.GI19249@S2101-09.ap.freescale.net>
References: <1340046070-1955-1-git-send-email-fabio.estevam@freescale.com>
 <20120619011737.GI19249@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5BkZ7wGK9xjJmdn4mQ+F0nXcm_7ethXzzK3pbeB1F8zFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Jun 18, 2012 at 04:01:10PM -0300, Fabio Estevam wrote:
>> mx23evk has 64MB of RAM, so fix the RAM size accordingly.
>>
> Are you sure about that? ?Please check hardware document again.

I see a MT46V32M16 DDR, which is 64MB.
