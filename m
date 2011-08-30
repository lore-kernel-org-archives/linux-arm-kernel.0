From: liu.h.jason@gmail.com (Jason Liu)
Date: Tue, 30 Aug 2011 10:49:08 +0800
Subject: [PATCH] ARM: mx25: Fix build by providing MX25_IIM_BASE_ADDR
	definition
In-Reply-To: <1314670868-13457-1-git-send-email-festevam@gmail.com>
References: <1314670868-13457-1-git-send-email-festevam@gmail.com>
Message-ID: <CAB4PhKee0pxw1p1BYNoA8CFi4_+PYHu1ece25wnouizOYb_AQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio,

2011/8/30 Fabio Estevam <festevam@gmail.com>:
> commit d27536c6 (ARM: mx25: Print silicon revision on boot) missed to include
> MX25_IIM_BASE_ADDR and caused the following build error:

Patch already there:
http://www.spinics.net/lists/arm-kernel/msg138315.html

Thanks,

BR,
Jason
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
