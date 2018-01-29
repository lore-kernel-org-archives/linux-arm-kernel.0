From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jan 2018 17:28:55 -0200
Subject: [PATCH v2 1/6] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <CAOMZO5C5D-Wx8Fre5uhKAijiKi4An5nmtzAT5YbuMCNGOqUaqg@mail.gmail.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-2-marc.zyngier@arm.com>
 <20180110175322.GZ3875@atomide.com>
 <6662dd72-121c-0cfb-ea31-aeecad4c7d03@arm.com>
 <87c06809-e035-52d7-0822-5fffb402c1dd@ti.com>
 <671e1901-f321-0731-45c7-19732970923b@arm.com>
 <CAOMZO5DK9xq-DfPbyerLL8+CHcsBjmd=ZBP27gWswTbFv-W1fg@mail.gmail.com>
 <CAOMZO5C5D-Wx8Fre5uhKAijiKi4An5nmtzAT5YbuMCNGOqUaqg@mail.gmail.com>
Message-ID: <CAOMZO5DJ2GvqRhN+14PzoPyiBbcUaNQXh2Ec0CqYLakRC95=iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 5:21 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Maybe by 'unconditional' you mean the revision check like this?

Ok, just noticed that Nishanth has posted a patch for U-Boot:
https://patchwork.ozlabs.org/patch/866033/
