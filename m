From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 24 May 2018 11:16:13 +0200
Subject: [PATCH v7 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFoZ16vhVvriLjyUSKwfym7HxHwn6Y92Q2ukXu9BG5GykA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep, Lorenzo, Mark

On 12 April 2018 at 13:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v7:
>  - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
>    the psci firmware driver to a new firmware subdir and change to force PSCI PC
>    mode during boot to cope with kexec'ed booted kernels.

Are you guys happy in general with the PSCI specific parts from this
series? It would be nice if you could provide me with acks or
reviewed-by tags for the rest of them in such case.

I intend to re-post a new version very soon.

[...]

Kind regards
Uffe
