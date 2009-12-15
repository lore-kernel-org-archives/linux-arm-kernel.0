From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Dec 2009 13:14:18 +0000
Subject: NEON support
In-Reply-To: <000401ca7d70$0122afa0$03680ee0$%yang@samsung.com>
References: <000401ca7d70$0122afa0$03680ee0$%yang@samsung.com>
Message-ID: <1260882858.1569.21.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-12-15 at 10:18 +0000, Jinsung Yang wrote:
> Does the latest Linux ARM kernel support full NEON features?
> Regarding this, as I know, it is necessary to backup and restore the
> NEON registers to run NEON instructions.

Yes, it supports (but you need to enable it in the kernel -
CONFIG_NEON).

-- 
Catalin
