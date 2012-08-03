From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Aug 2012 21:01:44 -0300
Subject: Several crashes on imx_v6_v7_defconfig
In-Reply-To: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
References: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
Message-ID: <CAOMZO5Boc7mMePGYjJV4ChzNkM8=xp4kSqnxGY3gaU7G_4qp6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 11:39 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> After manually fixing two build errors (patches already submitted, but
> they were not applied into linux-next yet) on imx_v6_v7_defconfig and
> booting a dt kernel on mx51evk I get:

Shawn's patch ([PATCH] ARM: dts: imx: fix gpio interrupts property)
fixed these issues.
