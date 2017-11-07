From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Nov 2017 11:55:01 +0100
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
 <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
Message-ID: <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:12:59AM +0000, Jon Hunter wrote:
> On 06/11/17 19:17, Mark Brown wrote:

> >>     multi_v7_defconfig:
> >>         tegra124-nyan-big:
> >>             lab-collabora: failing since 2 days (last pass: next-20171102 - first fail: next-20171103)

> Thanks for the report. I have been looking into a failure on nyan-big
> [0], but this one looks like a new failure. I will take a look.

Guillaume Tucker has been bisecting this with the shiny new bisection
code he's testing, he was saying on IRC he thinks he's found the
offending commit:

   https://people.collabora.com/~gtucker/tmp/bisect-tegra-4.14.rc8-next-20171106.txt

(not CCing Johannes yet)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/f83c694f/attachment.sig>
