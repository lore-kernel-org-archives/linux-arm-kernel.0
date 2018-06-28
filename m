From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 28 Jun 2018 17:44:33 +0300
Subject: [PATCH 2/2] ARM: mvebu_v7_defconfig: enable SFP support
In-Reply-To: <20180628151407.53231885@windsurf>
References: <ee69693c87cd0146f259042fc5dcd29338fcdf25.1530169575.git.baruch@tkos.co.il>
 <b130ccb8a9812530d33a71afb1563545fa8808cf.1530169575.git.baruch@tkos.co.il>
 <20180628151407.53231885@windsurf>
Message-ID: <20180628144433.ezel6xyi3ulppsog@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Jun 28, 2018 at 03:14:07PM +0200, Thomas Petazzoni wrote:
> On Thu, 28 Jun 2018 10:06:15 +0300, Baruch Siach wrote:
> > This enables support for SFP cages on SolidRun Armada 38x and 8k
> 
> You're running a 32-bit kernel on 8K platforms ?

No, though that is probably possible.

But you are right. In practice this patch only affects 32-bit mvebu platforms. 
Support for 8k platforms would require a separate patch.

Gregory, you mentioned earlier that mvebu branches are not immutable yet. Can 
you drop reference to 8k platforms from the commit log?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
