From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Thu, 26 Jun 2014 17:21:45 +0530
Subject: [PATCH RESEND] ARM: EXYNOS: Do not calculate boot address twice
In-Reply-To: <1403783163-28638-1-git-send-email-k.kozlowski@samsung.com>
References: <1403783163-28638-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAK5sBcGdYZRdOK7nDhGFn=TTsFmmp2ReajA+0o5w9u6WxSDR9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Thu, Jun 26, 2014 at 5:16 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Commit b3205dea8fbf ("ARM: EXYNOS: Map SYSRAM through generic DT
> bindings") introduced local variable boot_reg where boot address from
> cpu_boot_reg() call is stored. Re-use it instead calling cpu_boot_reg()
> again.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Thanks for the patch.
Reviewed-by: Sachin Kamat <sachin.kamat@samsung.com>

Regards,
Sachin.
