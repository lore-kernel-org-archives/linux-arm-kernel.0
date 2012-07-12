From: otavio@ossystems.com.br (Otavio Salvador)
Date: Wed, 11 Jul 2012 23:47:13 -0300
Subject: [PATCH v6 3/7] ARM: imx6q: disable usb charger detector
In-Reply-To: <20120712020646.GG6971@S2101-09.ap.freescale.net>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-4-git-send-email-richard.zhao@freescale.com>
 <20120712020646.GG6971@S2101-09.ap.freescale.net>
Message-ID: <CAP9ODKoBwxqk6yLsw=nZ272nrHCX9u3xkwWUEaNANrV-Zp5FOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 11:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
...
>> +     np = of_find_node_by_path("/soc/aips-bus at 02000000/anatop at 020c8000");
>
> I would suggest use of_find_compatible_node to save the open-coding of
> such path.
...

Nice catch!

-- 
Otavio Salvador                             O.S. Systems
E-mail: otavio at ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br
