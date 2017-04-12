From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 12 Apr 2017 20:51:13 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <87a87mhw5w.fsf@free-electrons.com>
References: <20170412083404.76cda3b3@canb.auug.org.au>
 <87a87mhw5w.fsf@free-electrons.com>
Message-ID: <20170412205113.5d96637c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Wed, 12 Apr 2017 10:23:07 +0200 Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>
> How do you want to proceed with this conflict?
> 
> Do you want that I merged arm-soc/next/arm64 in my mvebu/defconfig64
> branch before applying my patch ?
> 
> Or do you prefer that I continue to base my branch on v4.11-rc1 and then
> you will take care of the conflict when pulling the branch?

The conflict is trivial, I would hope that it will be handled when they
merge your tree.

-- 
Cheers,
Stephen Rothwell
