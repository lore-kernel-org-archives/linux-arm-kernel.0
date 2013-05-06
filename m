From: itooo@itooo.com (Greg)
Date: Mon, 06 May 2013 16:58:04 +0200
Subject: MVEBU PCI Express support
In-Reply-To: <20130506145225.67d04859@skate>
References: <5183F858.1050804@itooo.com> <20130506145225.67d04859@skate>
Message-ID: <5187C4FC.20504@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/05/2013 14:52, Thomas Petazzoni a ?crit :
> Dear Greg,
>
> On Fri, 03 May 2013 19:48:08 +0200, Greg wrote:
>
>> this one is targeted to the Free Electrons guys : should I start
>> investigating by myself or are you planning to release a patch for
>> supporting PCI express on Marvell Armada* platforms ?
> We have already posted 8 versions of the PCIe patches on this list. The
> last version is
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161968.html.
> However, this patch set has a few dependencies, so if you want
> something ready-to-use even if not yet in mainline, I would recommend
> you to have a look at
> https://github.com/MISL-EBU-System-SW/mainline-public/tree/backport-3.8.
> This is a 3.8 vanilla kernel into which we have backported a number of
> features/fixes, including the PCIe support.
>
> We're hoping to get PCIe support in mainline for 3.11.
> Thanks Thomas,

Sorry I'm not yet very familiar with all this (patches, repos, 
backports, branches, ...).
I'll give a try to the backport you suggest and, hopefully, get back to 
you with some feedback.

Cheers,
