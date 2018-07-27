From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 27 Jul 2018 14:15:57 -0700
Subject: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
In-Reply-To: <20180727005928.6bbe021f@xps13>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180718172849.30b7cec0@xps13> <20180725095222.054f1e80@xps13>
 <1532570441.2358.27.camel@intel.com>
 <20180726211442.GB3487@localhost.localdomain>
 <20180726213517.GA15690@localhost.localdomain>
 <20180726221423.GA3569@localhost.localdomain>
 <20180727005928.6bbe021f@xps13>
Message-ID: <20180727211556.GA4450@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 12:59:28AM +0200, Miquel Raynal wrote:
> Hi Eduardo,
> 
> Eduardo Valentin <edubezval@gmail.com> wrote on Thu, 26 Jul 2018
> 15:14:24 -0700:
> 
> > 
> > 
> > Given that I let this one fall into the cracks and that these are minor
> > issues, I fixed them manually, and applied up to patch 19. But next at
> > least compile test your series and run checkpatch on them.
> 
> I was really surprised of your remark but indeed there was a build
> issue in the middle of the series that I did not see because I always
> test with a last patch fixing it (this patch adds interrupt support, I
> plan to send it for the next release). I'm very sorry for this
> mistake, thanks for fixing it by yourself.

Oh, you cannot do that :-). You have to diligently test each patch.

> 
> > 
> > Patches 20-23 need to go via your arch tree.
> 
> Sure, they will enter in the next release now.
> 
> Thanks,
> Miqu?l
