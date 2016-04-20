From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 20 Apr 2016 11:30:12 -0500
Subject: [PATCH 2/3] ACPI / ARM64: Remove EXPERT dependency for ACPI on
 ARM64
In-Reply-To: <1460706823-16566-2-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
 <1460706823-16566-2-git-send-email-broonie@kernel.org>
Message-ID: <CAOZdJXWzqwZMHV0Qu4FE=j+N3oP3XrDN-+AqUhG61wxFdC945w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 2:53 AM, Mark Brown <broonie@kernel.org> wrote:
>
> Given all this it seems that at this point the EXPERT dependency mainly
> creates inconvenience for users with systems that are doing the right
> thing and gets in the way of including the ACPI code in the testing that
> people are doing on mainline.  Removing it should help our ongoing
> testing cover those platforms with only ACPI support and help ensure
> that when ACPI code is merged any problems it causes for other users are
> more easily discovered.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Acked-by: Graeme Gregory <graeme.gregory@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Al Stone <ahs3@redhat.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
