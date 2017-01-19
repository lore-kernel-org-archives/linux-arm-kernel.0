From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Thu, 19 Jan 2017 18:46:32 +0530
Subject: [PATCH 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170118221315.GP27312@n2100.armlinux.org.uk>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203837.6536-1-afzal.mohd.ma@gmail.com>
 <20170118221315.GP27312@n2100.armlinux.org.uk>
Message-ID: <20170119131632.GA3862@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 18, 2017 at 10:13:15PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 19, 2017 at 02:08:37AM +0530, afzal mohammed wrote:

> > +			MLK_ROUNDUP(vectors_base, vectors_base + PAGE_SIZE),
> 
> I think MLK() will do here - no need to use the rounding-up version
> as PAGE_SIZE is a multiple of 1k.

Yes, i will replace it.

Earlier, used MLK(), got some build error, now checking again, no
build error, i should have messed up something at that time.

Regards
afzal
