From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 23 Mar 2010 13:05:13 +0900
Subject: [PATCH] uImage: Allow to specify MKIMAGE
In-Reply-To: <20100320184907.8036.82488.stgit@localhost.localdomain>
References: <20100320184907.8036.82488.stgit@localhost.localdomain>
Message-ID: <20100323040513.GB13417@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 08:49:07PM +0200, Paulius Zaleckas wrote:
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
> 
>  arch/arm/boot/Makefile          |    4 ++--
>  arch/avr32/boot/images/Makefile |    4 ++--
>  arch/blackfin/boot/Makefile     |    4 ++--
>  arch/microblaze/boot/Makefile   |    4 ++--
>  arch/sh/boot/Makefile           |    4 ++--
>  scripts/mkuboot.sh              |    1 +
>  6 files changed, 11 insertions(+), 10 deletions(-)
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
