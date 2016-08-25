From: mbrugger@suse.com (Matthias Brugger)
Date: Thu, 25 Aug 2016 13:04:56 +0200
Subject: [PATCH v4 1/4] arm64: arch_timer: Add device tree binding for
 A-008585 erratum
In-Reply-To: <1467877572-10817-1-git-send-email-oss@buserror.net>
References: <1467877572-10817-1-git-send-email-oss@buserror.net>
Message-ID: <e69db8b1-5fe2-ed0a-b073-de3efdd854d2@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 07/07/16 09:46, Scott Wood wrote:
> This erratum describes a bug in logic outside the core, so MIDR can't be
> used to identify its presence, and reading an SoC-specific revision
> register from common arch timer code would be awkward.  So, describe it
> in the device tree.
>
> Signed-off-by: Scott Wood <oss@buserror.net>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

As of today I wasn't able to find this series in linux-next. Was this 
series somehow forgotten? Scott maybe you can resend the patches adding 
the clocksource maintainer.

Regards,
Matthias
