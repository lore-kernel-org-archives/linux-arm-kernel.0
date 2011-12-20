From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 20 Dec 2011 06:30:28 +0000
Subject: [PATCH v6 02/11] ARM: davinci: dm644x: remove the macros from
 the	header to move to c file
In-Reply-To: <1323951120-15876-3-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
 <1323951120-15876-3-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B604FFDD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

"remove the macros from the header to move to c file" in subject line
is too convoluted to read and doesn't convey the real purpose of the
patch. It can simply be stated as:

"move private definitions to C file"

On Thu, Dec 15, 2011 at 17:41:51, Hadli, Manjunath wrote:
> move the register base addresses and offsets used only by dm644x
> platform file from platform header dm644x.h to dm644x.c as they
> are used only in the c file.

And add here:

This helps reduce code in arch/arm/mach-davinci/include/mach
which is not really needed by rest of the kernel.

You have already spun 6 versions of the patch so I will just
make these changes locally and commit it. No need to send
a replacement.

Thanks,
Sekhar
