From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 10:58:53 +0000
Subject: [PATCH 1/4] add a mc13783 codec driver
In-Reply-To: <1496586.ebXd01ibP4@laptop>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <20120311113848.GA3233@opensource.wolfsonmicro.com>
 <1496586.ebXd01ibP4@laptop>
Message-ID: <20120312105852.GE3110@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 09:11:08AM +0100, Philippe R?tornaz wrote:

> Thank you for this detailed review. I will redo the patch based on your 
> comments. I had a quick look at DAPM (dapm.txt in asoc documentation), but is 
> there any good "reference" implementation which is in the kernel where I could 
> have a look ? 

Pretty much all ASoC drivers use DAPM and there's really not much
variation in quality in terms of how they do so, it's mostly an either
it works or doesn't thing.  Just look for something maintained that you
can follow and/or which is fairly close to your hardware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/d1ce2b81/attachment-0001.sig>
