From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 23 Sep 2010 12:42:20 -0700
Subject: [PATCH 1/3] dmaengine: add possibility for cyclic transfers
In-Reply-To: <20100920130119.GA23406@pengutronix.de>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
	<20100920130119.GA23406@pengutronix.de>
Message-ID: <AANLkTi=B1ZkoYZ3hjuzz8Uj=W-04cE+iedaMwurUMRPy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 6:01 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Dan,
>
> Any comment to this patch?

Looks good to me especially given the unique implications for
callbacks.  Although, I'd like to put a description of the
prep_dma_cyclic semantics in the source code.  Can you respin this
with a description added to the kernel-doc for struct dma_device?

--
Dan
