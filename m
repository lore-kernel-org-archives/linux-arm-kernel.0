From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Jun 2017 08:59:13 +0200
Subject: linux-next: bad commit in the mvebu tree
In-Reply-To: <20170616055732.4114daed@canb.auug.org.au> (Stephen Rothwell's
 message of "Fri, 16 Jun 2017 05:57:32 +1000")
References: <20170616055732.4114daed@canb.auug.org.au>
Message-ID: <87tw3g5sfy.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,
 
 On jeu., juin 15 2017, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> I noticed that commit
>
>   c6f4e66bd0f4 ("arm64: marvell: dts: add xmdio nodes for 7k/8k")
>
> has no Signed-off-by for its comitter.

Thanks for the warning, I fix it right now.

Gregory


>
> -- 
> Cheers,
> Stephen Rothwell

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
