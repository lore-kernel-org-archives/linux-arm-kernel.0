From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 12:19:11 +0100
Subject: [PATCH v2 04/20] arm64: atomics: move ll/sc atomics into
 separate header file
In-Reply-To: <1437734531-10698-5-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-5-git-send-email-will.deacon@arm.com>
Message-ID: <20150724111911.GE3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:55AM +0100, Will Deacon wrote:
> In preparation for the Large System Extension (LSE) atomic instructions
> introduced by ARM v8.1, move the current exclusive load/store (LL/SC)
> atomics into their own header file.
> 
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
