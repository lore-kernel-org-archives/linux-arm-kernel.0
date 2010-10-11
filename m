From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 11 Oct 2010 17:05:22 +0800
Subject: [PATCH 02/14 v2] ARM: pxa: Access SMEMC via virtual addresses
In-Reply-To: <1286756432-5873-2-git-send-email-marek.vasut@gmail.com>
References: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
	<1286756432-5873-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTinPrnQWDYcuTJq5Rmmq0vO1DNGfYw34r_EDDPQZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 8:20 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This is important because on PXA3xx, the physical mapping of SMEMC registers
> differs from the one on PXA2xx. In order to get PCMCIA working on both PXA2xx
> and PXA320, the PCMCIA driver was adjusted accordingly as well.
>
> Also, various places in the kernel had to be patched to use
> __raw_read/__raw_write.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
