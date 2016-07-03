From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jul 2016 09:05:16 -0300
Subject: [PATCH RFC 0/7] support clk setting during kernel early boot
In-Reply-To: <bab9b9bacc16a42cf9ca93973ea5de68@agner.ch>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
 <20160702011216.GR27880@codeaurora.org>
 <bab9b9bacc16a42cf9ca93973ea5de68@agner.ch>
Message-ID: <CAOMZO5D+D3HSPJ+6mpnsBt+NsZ=zubBZHunBGTYhkSgZyegaGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sat, Jul 2, 2016 at 8:12 PM, Stefan Agner <stefan@agner.ch> wrote:

> I found that remark interesting, and agree here with Stephen, critical
> clks should be already on and everything else should be controlled from
> drivers.
>
> With that in mind I went on and looked again what is currently (after
> the parents enable patchset) still wrong on i.MX 7. Turned out to be not
> that much, and I think it should be fixable with that:
> https://lkml.org/lkml/2016/7/2/138

If I only applied your patch against linux-next I still get:
http://pastebin.com/zx7kAzfd
