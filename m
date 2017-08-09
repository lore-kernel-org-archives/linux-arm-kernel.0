From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 9 Aug 2017 20:22:57 +0100
Subject: [PATCH 12/15] arm-soc: omap: replace open coded VA->PA
 calculations
In-Reply-To: <20170809190556.GD3934@atomide.com>
References: <20170805205222.19868-1-ard.biesheuvel@linaro.org>
 <20170805205222.19868-13-ard.biesheuvel@linaro.org>
 <20170809190556.GD3934@atomide.com>
Message-ID: <CAKv+Gu-kdjN8nXVNL2frsegu-z7HVnG8qcXpQbvM-oBbxKjUGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2017 at 20:05, Tony Lindgren <tony@atomide.com> wrote:
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> [170805 13:54]:
>> This replaces a couple of open coded calculations to obtain the
>> physical address of a far symbol with calls to the new adr_l etc
>> macros.
>
> I gave this series a quick test and omap3 no longer boots it seems.
>

Thanks Tony. I will investigate
