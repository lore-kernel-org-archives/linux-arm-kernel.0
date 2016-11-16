From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Nov 2016 20:27:09 -0200
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <20161116221002.GA19925@roeck-us.net>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
 <20161116184649.GF11228@leverpostej> <20161116221002.GA19925@roeck-us.net>
Message-ID: <CAOMZO5Bd2X3pVqExBtBw_uHReDDkf6J2VdMXnAXynCAHxoX60A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Wed, Nov 16, 2016 at 8:10 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Anyway, I guess the problem is that the "official" dtb files no longer provide
> the skeleton /chosen and /memory nodes (and maybe others), and qemu seems to
> expect that they are provided. Is that correct ?

imx6qdl-sabrelite.dtsi provides chosen and memory nodes.
