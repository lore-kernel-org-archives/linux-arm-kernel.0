From: x0066660@ti.com (Arce, Abraham)
Date: Thu, 9 Dec 2010 00:34:15 -0600
Subject: [PATCH] msm: trout: add keypad support
In-Reply-To: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <AANLkTikOOH3qHHRtqETytYBk_MiCeVBU724CooUYqgdy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, Dec 8, 2010 at 6:24 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> This adds matrix keypad support, and gpio buttons support for
> trout's various keys and buttons.
>
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> ---
> ?arch/arm/mach-msm/Makefile ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-msm/board-trout-keypad.c | ?342 ++++++++++++++++++++++++++++++++
> ?2 files changed, 343 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/mach-msm/board-trout-keypad.c
>

[...]

> +
> +static unsigned int trout_col_gpios_evt2[] = { 35, 34, 33, 32, 31, 23, 30, 109 };

WARNING: line over 80 characters

[...]

Best Regards
Abraham
