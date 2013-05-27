From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 May 2013 18:04:17 +0200
Subject: [PATCH v3] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <8424D480-48DA-4094-AE68-6A6A66F8FE2B@jcrosoft.com>
References: <1369651702-9207-1-git-send-email-alexandre.belloni@free-electrons.com>
 <E0B30581-DD0A-46C5-B541-08F389F17018@jcrosoft.com>
 <51A356A2.4050502@free-electrons.com>
 <8424D480-48DA-4094-AE68-6A6A66F8FE2B@jcrosoft.com>
Message-ID: <51A38401.5000103@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/2013 14:59, Jean-Christophe PLAGNIOL-VILLARD wrote:
>
> no will not as you do ifdef CONFIG_PHYLIB and if CONFIG_PHYLIB=m the macro is defended
>
> we do this all the time in the kernel
>
> I add the IS_BUILTIN & co to be used when a simple inline is not sufficient

Ok, it took me a while to understand what you were trying to explain.
I'm sending a patch set now. I don't believe it will be taken in for
3.10 though.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
