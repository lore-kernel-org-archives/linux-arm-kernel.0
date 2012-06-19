From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 09:34:14 +0800
Subject: [PATCH] ARM: imx23-evk.dts: Fix total RAM size
In-Reply-To: <CAOMZO5BkZ7wGK9xjJmdn4mQ+F0nXcm_7ethXzzK3pbeB1F8zFw@mail.gmail.com>
References: <1340046070-1955-1-git-send-email-fabio.estevam@freescale.com>
 <20120619011737.GI19249@S2101-09.ap.freescale.net>
 <CAOMZO5BkZ7wGK9xjJmdn4mQ+F0nXcm_7ethXzzK3pbeB1F8zFw@mail.gmail.com>
Message-ID: <CAAQ0ZWQ-YFJfKQ+3SfzxcLmYxzUKG1Q+o3KtdRtwpEJv3Z+EAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2012 09:32, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 18, 2012 at 10:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Mon, Jun 18, 2012 at 04:01:10PM -0300, Fabio Estevam wrote:
>>> mx23evk has 64MB of RAM, so fix the RAM size accordingly.
>>>
>> Are you sure about that? ?Please check hardware document again.
>
> I see a MT46V32M16 DDR, which is 64MB.

There are two.  One is on the top, and the other is on the bottom.

Regards,
Shawn
