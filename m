From: hvdmerwe@tmtservices.co.za (Hennie van der Merwe)
Date: Tue, 19 Jan 2010 07:43:32 +0200
Subject: [PATCH - 3rd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <f17812d71001182129v30b93f0dw72a950cec630bf10@mail.gmail.com>
References: <201001182134.14226.epeer@tmtservices.co.za>
	<20100118215124.GE8970@buzzloop.caiaq.de>
	<4B55400C.1050109@tmtservices.co.za>
	<f17812d71001182129v30b93f0dw72a950cec630bf10@mail.gmail.com>
Message-ID: <4B554684.3020803@tmtservices.co.za>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> You could make this declaration in .h file, e.g.
>
> #ifdef ...
> extern void mxm_8x10_mmc_init(void);
> #else
> static inline void mxm_8x10_mmc_init(void) {}
> #endif
> which will be optimized away by the compiler.
Perfect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hvdmerwe.vcf
Type: text/x-vcard
Size: 373 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100119/681f2737/attachment.vcf>
