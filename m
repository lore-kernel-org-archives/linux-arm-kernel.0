From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 17 Sep 2015 14:44:55 -0700
Subject: [PATCH v2 0/3] Add __ioread32_copy() and use it
In-Reply-To: <20150917214218.GA6003@qualcomm.com>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
 <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
 <20150917214218.GA6003@qualcomm.com>
Message-ID: <20150917144455.8b414be4f89688bbdca39692@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Sep 2015 16:42:18 -0500 Andy Gross <agross@codeaurora.org> wrote:

> > ho hum.  I think I'll go with plan B: merge just "lib: iomap_copy: Add
> > __ioread32_copy()" and send that into Linus promptly.  That way you
> > guys can sort out the driver patches in the usual fashion.
> > 
> 
> I just pulled in the original 8 patches and rebased.  My plans were to stage
> those in linux-next through my for-next.  Then add those on top just like you
> specified.  But i could go either way.

OK, please do that.
