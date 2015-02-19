From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Feb 2015 00:43:33 +0300
Subject: [PATCH v2 0/2] Add R8A7790 CAN DT support
In-Reply-To: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
References: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
Message-ID: <54E65905.7090009@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 12:31 AM, Sergei Shtylyov wrote:

>     Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20141231-v3.19-rc2' tag. Here we add the CAN device tree support
> for the R8A7790 SoC (unfortunately, it's impossible to test CAN on the Lager
> board). It depends on the clk driver RCAN clock patch reposted today in order
> to work.

    Simon, now that this patch has been merged, could you merge this patchset too?

> [1/2] ARM: shmobile: r8a7790: add CAN clocks
> [2/2] ARM: shmobile: r8a7790: add CAN DT support

WBR, Sergei
