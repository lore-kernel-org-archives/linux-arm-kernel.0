From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 16:58:06 +0100
Subject: [PATCH V3 resend] ST SPEAr: Adding support for shared irq layer
In-Reply-To: <1272874954-3459-1-git-send-email-viresh.kumar@st.com>
References: <1272874954-3459-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100504155805.GC30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 03, 2010 at 01:52:34PM +0530, Viresh KUMAR wrote:
> diff --git a/arch/arm/mach-spear6xx/include/mach/irqs.h b/arch/arm/mach-spear6xx/include/mach/irqs.h
> index 08a3abc..8f214b0 100755

BTW, please ensure that non-exec files are created with mode 644;
although I fixed these up in your original patch submission, and
this patch, it's not something I'm going to do regularly.

Thanks.
