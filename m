From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2012 09:40:27 +0100
Subject: [PATCH 2/4] ARM: mm: don't use the access flag permissions
 mechanism for classic MMU
In-Reply-To: <1348156605-30398-3-git-send-email-will.deacon@arm.com>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <1348156605-30398-3-git-send-email-will.deacon@arm.com>
Message-ID: <20120921084027.GB21464@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 04:56:43PM +0100, Will Deacon wrote:
> The simplified access permissions model is not used for the classic MMU
> translation regime, so ensure that it is turned off in the sctlr prior
> to turning on address translation for ARMv7.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
