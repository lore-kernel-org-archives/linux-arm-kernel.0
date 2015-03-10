From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 9 Mar 2015 22:51:53 -0300
Subject: [PATCH v2 3/3] ARM: mx25: Remove platform code support files
In-Reply-To: <21909740.nfZYRJLb3G@wuerfel>
References: <1425662758-4675-1-git-send-email-festevam@gmail.com>
 <1425662758-4675-3-git-send-email-festevam@gmail.com>
 <21909740.nfZYRJLb3G@wuerfel>
Message-ID: <CAOMZO5BC-pebQfbFhKBJAXto=6f6osHRW4V0kwvLJqzFuQVUqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 9, 2015 at 6:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Very nice, good to see some progress on the old machines!
>
> If you find the time, could you summarize your plans for the remaining
> i.MX SoCs that have board files (imx21, imx27, imx31, imx35)? Do you plan
> to continue with those, one by one?

After this series gets applied I will submit another one removing the
remaining mx25 leftovers pieces.

mx27 can be the next one to be converted to dt-only (still need to get
ov2640 camera, mc13783 audio and LCD to work in imx27-pdk.dts though).

mx35 should also be simple to convert to dt-only.

mx31 still lacks pinctrl.

I don't have access to imx1/imx21 hardware.

Hopefully someday we can get imx to be dt-only.

Regards,

Fabio Estevam
