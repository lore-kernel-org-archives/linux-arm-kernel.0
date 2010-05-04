From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 17:05:22 +0100
Subject: [PATCH] ARM: Gemini: fix compiler error in copypage-fa.c
In-Reply-To: <1272983655-18408-1-git-send-email-ulli.kroll@googlemail.com>
References: <1272983655-18408-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <20100504160522.GD30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 04:34:15PM +0200, Hans Ulli Kroll wrote:
> Fix compiler error in copypage-fs.c
> missing struct vm_area_struct *vma in function
> fa_copy_user_highpage

Ok.  Please submit to the patch system, thanks.
