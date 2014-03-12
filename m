From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Mar 2014 14:56:53 +0000
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
In-Reply-To: <b9ecee11764146c98dd41b811ebc05ae@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140306065339.GA2975@localhost>
 <b9ecee11764146c98dd41b811ebc05ae@BN1PR03MB266.namprd03.prod.outlook.com>
Message-ID: <20140312145653.GA9691@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 02:41:31PM +0000, Bharat.Bhushan at freescale.com wrote:
> Did you get the chance to look into this? What is your take for this patch
> or you want to suggest some other solution?

See my reply to Laura here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/238510.html

We *really* don't want executable device mappings.

Will
