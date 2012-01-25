From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jan 2012 11:23:13 +0000
Subject: [PATCH 2/5] ARM: pgtable: use mk_pte rather than
 pfn_pte(page_to_pfn())
In-Reply-To: <E1RoBoY-0005oU-Lc@rmk-PC.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
 <E1RoBoY-0005oU-Lc@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk5bEAX1aQ3eP8-Yt16ncCVESn2+DHQy2Hmh_dMCu3pjhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 10:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> mk_pte is provided to do this translation for us, so use it rather
> than open-coding it in the copypage code.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
