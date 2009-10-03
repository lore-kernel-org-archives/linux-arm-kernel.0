From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sat, 03 Oct 2009 20:19:17 +0100
Subject: git an patches: Some questions
In-Reply-To: <4AC660CE.600@techworks.ie>
References: <4AC660CE.600@techworks.ie>
Message-ID: <4AC7A3B5.2080606@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud wrote:
> Hi all,
> 
> I would like to have some advice on how to manage my git tree, patches 
> that I pick on this list (EP93XX related) and patches that I would like 
> to submit (TS-72XX related).
> 
> First of all I would like to know what tools people are using, I've read 
> about stg [1][2] and it looks to me that it fits well my needs.
> 
> Next, I'm would like to know the best strategy to track the latest 
> patches from linux-arm and at the same time work on my own patches.
> Should I create a branch, say ep93xx, that track linux tree and on which 
> i apply the EP93xx patches, and set up another branch, say ts72xx, that 
> track the ep93xx branch? Or should i use only one branch and use "stg 
> import" for patches I'm not the author and "stg new" for my own work.
> 
> Using stg import/new looks interesting, but then if I want to submit my 
> patches by email, stg will send all the patch part of the series 
> including the one that I've imported but that's not what I'm looking for.
> 
> Any help, advice or point-out appreciated.

Actually stg is really a great tool, very easy to use!
Their tutorial was of a great help to get up to speed quickly.

Chris

> Thanks,
> Chris
> 
> [1] http://wiki.openmoko.org/wiki/Hints_on_using_GIT_and_stgit
> [2] http://www.procode.org/stgit/doc/tutorial.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
