From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Nov 2011 09:40:27 +0100
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
In-Reply-To: <20111129064630.GW19069@tbergstrom-lnx.Nvidia.com>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
 <20111129064630.GW19069@tbergstrom-lnx.Nvidia.com>
Message-ID: <CACRpkdY-YL0RSY4+nL36sM9WwX+VbMkJP54djrCwYCQmw9AFEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 7:46 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> On Thu, Nov 03, 2011 at 06:00:44PM +0100, Peter De Schrijver wrote:
>> This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested by
>> Russel King. It also converts some platforms to the new model.
>>
>> Peter De Schrijver (3):
>> ? ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
>> ? ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
>> ? ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO
>
> Ping? What should we do with this?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Put it into Russell's patch tracker.

Yours,
Linus Walleij
