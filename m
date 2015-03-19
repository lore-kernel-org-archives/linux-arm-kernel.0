From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Wed, 18 Mar 2015 20:01:53 -0700
Subject: [PATCH] arm64: defconfig: increase NR_CPUS range to 2-4096.
In-Reply-To: <1426676478-12870-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1426676478-12870-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <CAMDttNePYmTEzUrwgssGCQW0uRnCBROD2x7W9eZeDzib0p-G-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 4:01 AM, Ganapatrao Kulkarni
<gkulkarni@caviumnetworks.com> wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
>
> Raising the maximum limit to 4096.
> This is to accomadate up-coming higher multi-core platforms.

s/accomadate/accomodate/

>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> ---

Acked-by: Zi Shen Lim <zlim@broadcom.com>
