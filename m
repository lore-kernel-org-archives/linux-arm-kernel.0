From: lenb@kernel.org (Len Brown)
Date: Fri, 15 Aug 2014 18:43:10 -0400
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CAJvTdKnTLtozLZnAJcgZODV9-D77u3=hK3d7z-5XCZZTFwhqOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Additional driver specific
> +data should be passed in the appropriate _DSM (ACPI Section 9.14.1) method or
> +_DSD (ACPI Section 6.2.5).

Re: _DSD

Yes.

Re: _DSM

No, not if it can be handled by _DSD.

cheers,
Len Brown, Intel Open Source Technology Center
