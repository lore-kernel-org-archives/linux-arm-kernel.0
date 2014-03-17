From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 11:11:30 +0100
Subject: [GIT PULL V2] ARM: mvebu: dt changes for v3.15 (incr. pull #3)
In-Reply-To: <20140304025559.GY1872@titan.lakedaemon.net>
References: <20140301052536.GS1872@titan.lakedaemon.net>
 <20140304025559.GY1872@titan.lakedaemon.net>
Message-ID: <201403171111.30596.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, Jason Cooper wrote:
> V2: removed the dove PMU interrupt node (er, undid the re-addition of
> the node.  ie: let the revert stand).  So, commit id's for this pull
> only are changed.  No previous pulls or tags affected.  Confirmed the
> change with a diff between the old branch and the new branch.  And did a
> run of building dtbs.  No problems.  Sorry for the confusion.
> 
> Russell just raised a very valid point today regarding the overall
> design of an eventual PMU driver that would cover several tasks we
> hadn't considered with the original binding.  Better to pull it now than
> have to support it indefinitely.  Revert of the driver in the works.
> 
> --- original text ---
> 
> Here's another rather large round of DT changes for mvebu.  It's all
> summed up below and has been in -next for a while now.
> 
> This is an incremental pull from tags/mvebu-dt-3.15-2 in the mvebu/dt
> branch up to tags/mvebu-dt-3.15-3.
> 

Pulled into next/dt now, along with the #4 and #5. I got a trivial
merge conflict against the dts Makefile change from mach-qcom and
noticed that splitting up the dtb section into per-soc breaks
alphabetical ordering, which I changed in the merge by moving
it down to the end of the list.

	Arnd
