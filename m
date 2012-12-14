From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 14 Dec 2012 12:21:07 +0900
Subject: [PATCH 2/2] ARM: SH-Mobile: sh73a0: Add CPU Hotplug
In-Reply-To: <1354795719-5578-2-git-send-email-hechtb+renesas@gmail.com>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
 <1354795719-5578-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <CANqRtoQ2OWXsUZU1qMO4iz_BG0oY32b9UYYv+hLSYmzdCEJ24w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 6, 2012 at 9:08 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> From: Bastian Hecht <hechtb@gmail.com>
>
> Add the capability to add and remove CPUs on the fly.
> The Cortex-A9 offers the possibility to take single cores out of the
> MP Core. We add this capabilty taking care that caches are kept
> coherent. For the actual shutdown via a WFI instruction, a code snippet
> from the omap2 code tree is copied. Thanks for that! For verifying the
> shutdown we rely on the internal SH73A0 Power Status Register
> PSTR.
>
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Acked-by: Magnus Damm <damm@opensource.se>
