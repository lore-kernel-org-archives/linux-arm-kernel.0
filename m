From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 01:54:20 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20160426094331.64032731@canb.auug.org.au>
References: <20160426094331.64032731@canb.auug.org.au>
Message-ID: <8018210.3MZgHs9g7Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 09:43:31 Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm-soc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "of_flash_probe_versatile" [drivers/mtd/maps/physmap_of.ko] undefined!
> 
> Caused by commit
> 
>   b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
> 
> I used the arm-soc tree from next-20160422 for today.
> 

Ah, sorry about that. I think I fixed it up just as you pulled it in.
If you don't mind, could you try pulling the tree once more on top
of what you have?

	Arnd
