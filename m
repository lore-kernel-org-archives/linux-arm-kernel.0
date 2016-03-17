From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 17 Mar 2016 12:20:37 -0500
Subject: [PATCH v4 2/4] ACPI: enable ACPI_SPCR_TABLE on ARM64
In-Reply-To: <1456747355-15692-3-git-send-email-aleksey.makarov@linaro.org>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
 <1456747355-15692-3-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAOZdJXV1KWyguPw33C+EF12TBDsg5Ds4AX-40gVefkhHwddW2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 6:02 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> SBBR mentions SPCR as a mandatory ACPI table.
> So enable it for ARM64
>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

Tested-by: Timur Tabi <timur@codeaurora.org>

I know another version of patch is coming, but I tested this version
and it works.
