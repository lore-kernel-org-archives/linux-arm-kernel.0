From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Tue, 7 Nov 2017 18:05:01 -0200
Subject: [PATCH] ARM: dts: imx7d-pico-pi: Separate into cpu and baseboard
 dts
In-Reply-To: <1510079483-24012-1-git-send-email-vanessa.maegima@nxp.com>
References: <1510079483-24012-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <CAP9ODKrNzLkOt76=b58S3TioXBk1FrS4XpPkPQCN48mcAP-GVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 4:31 PM, Vanessa Maegima <vanessa.maegima@nxp.com> wrote:
> Separate the old imx7d-pico into cpu (imx7d-pico.dtsi) and baseboard
> (imx7d-pico-pi.dts) dts so the same cpu dtsi can be used in different
> baseboards variants.
>
> Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>

Thanks for looking at this Vanessa, one question though is if it is
allowed to just drop the old dtb file or we need to keep it for
backward compatibility?

Honestly, it was not available for a long time so I would personally
be fine with just renaming it but I don't know about the police on
this.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
