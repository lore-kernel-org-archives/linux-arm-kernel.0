From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2018 09:22:47 -0300
Subject: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
In-Reply-To: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
References: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5Coi-LRXG8vepnm-eSSx75LLEtsZ90WrtK6rEy76u+OBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Fri, Jun 22, 2018 at 3:28 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SLL EVK board, PFuze100's SW4 is supplying
> LPDDR3, it needs to be always on. This patch fixes
> Linux kernel boot up hang caused by SW4 being turned
> off:
>
> [    1.693613] cfg80211: failed to load regulatory.db
> [    1.700063] SW4: disabling
> [    1.703973] SWBST: disabling

It would be nice to mention in the commit log what was the patch that
caused the breakage, just like Robin did for imx6sl-evk.

Thanks,
