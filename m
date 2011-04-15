From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Fri, 15 Apr 2011 10:49:42 -0500
Subject: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
In-Reply-To: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
References: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <BANLkTin=br7Yw39fnhXbLQg-Wgzym1BXJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Fri, Mar 25, 2011 at 3:04 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Commit d038aee24dcd5a2a0d8547f5396f67ae9698ac8e
> "omap: iovmm: don't check 'da' to set IOVMF_DA_FIXED flag",
> changes iovmm to receive flags specified by user, however
> the upper 16 bits of the flags are wiped by iovmm itself.
>
> This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
> map its desired "device addresses".
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>
> v2:
> Include missing reference (commit and name) to patch in
> description.

If no comments, could you ack this patch?

Regards,

Omar
