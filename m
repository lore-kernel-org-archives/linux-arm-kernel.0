From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Mar 2012 20:20:20 -0400
Subject: linux-next: build failure after merge of the final tree
 (arm-soc tree related)
In-Reply-To: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
References: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
Message-ID: <20120315002020.GA16189@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 10:59:01AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allmodconfig) failed like this:
> 
> drivers/ata/sata_mv.c:4185:1: error: '__mod_of_device_table' aliased to undefined symbol 'mvsdio_dt_ids'
> 
> Caused by commit f1e1e148c5cb ("ARM: kirkwood: sata_mv: add device tree
> binding").

Stephen,

That's my mistake.  I did a pull request for the wrong branch.  Olof,
could you please drop the offending branch and I'll submit a new pull
request once I have a chance to test Arnd's irq patch?

thx,

Jason.
