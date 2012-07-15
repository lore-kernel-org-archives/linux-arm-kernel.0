From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 15 Jul 2012 22:40:34 +0100
Subject: Device tree binding for DVFS table
In-Reply-To: <50006935.2080606@nvidia.com>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50006935.2080606@nvidia.com>
Message-ID: <20120715214033.GK4041@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 12:00:14AM +0530, Prashant Gaikwad wrote:
> On Thursday 12 July 2012 09:38 AM, Prashant Gaikwad wrote:

> >About repeating frequencies, operating voltage for a frequency
> >would be the highest one mapped in the table.

This sounds very surprising...  that would generally just result in
higher power consumption.

> >I know this makes reading difficult but it provides flexibility,

> Does this explanation help?

The loss of comprehensibility seems like a really major disadvantage for
very little practical gain here.  Big arrays in DT are already hard
enough to read without adding extra complexity on top of that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120715/d6dbc57c/attachment.sig>
