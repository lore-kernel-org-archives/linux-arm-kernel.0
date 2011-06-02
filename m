From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Jun 2011 13:48:40 +0100
Subject: [PATCH] arm: vexpress: move v2m clock init to init_early
In-Reply-To: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
References: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
Message-ID: <BANLkTinA=4k6-8bn8N1P8VwX19B_6LEbcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2011 23:30, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Commit 7ff550de99141cbd3be0129d563cc4554fdde9f6 breaks vexpress booting. The
> v2m clock table needs to be setup in init_early before the timer
> initialization occurs.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> ?arch/arm/mach-vexpress/v2m.c | ? 15 +++++++--------
> ?include/linux/libata.h ? ? ? | ? ?4 ++--

Apart from the libata.h changes, the patch works for me.

Tested-by: Catalin Marinas <catalin.marinas@arm.com>
