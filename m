From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Aug 2017 15:19:30 +0200
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <20170830230712.55db7911@canb.auug.org.au>
References: <20170830230712.55db7911@canb.auug.org.au>
Message-ID: <20170830131930.bvu6furm7dlhes3i@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/2017 at 23:07:12 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   1a9f9af07e80 ("ARM: dts: at91: at91sam9g45: add AC97")
> 
> is missing a Signed-off-by from its author.
> 

Oh crap, it was the only one not in linux-next... iThe original
submission had the SoB:
https://patchwork.kernel.org/patch/9794803/

Olof, how do you want to proceed?

> -- 
> Cheers,
> Stephen Rothwell

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
