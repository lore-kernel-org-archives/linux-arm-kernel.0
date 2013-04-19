From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Apr 2013 13:31:50 +0100
Subject: [PATCH] ARM64: kernel: compiling issue, duplicate definition
 of early_console
In-Reply-To: <51712213.4060607@asianux.com>
References: <5152DB83.8080703@asianux.com>
 <20130327115509.GA1603@MacBook-Pro.local>
 <5152DFF1.2090000@asianux.com> <515BE49C.8040601@asianux.com>
 <515C14FD.4040703@codeaurora.org> <515C2808.70406@asianux.com>
 <516E66F9.9070904@asianux.com> <51712213.4060607@asianux.com>
Message-ID: <20130419123150.GA18443@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 11:53:07AM +0100, Chen Gang wrote:
>   when compiling with allmodconfig.
>     early_console is already defined as an extern global pointer.
> 
>   need let it point to the object which we intend to (like ARM32 done).
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Thanks for the patch.

-- 
Catalin
