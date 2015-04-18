From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 18 Apr 2015 20:49:03 +0200
Subject: [RFC PATCH 2/2] tee: add OP-TEE driver
In-Reply-To: <FCFF5E10-0DDC-4ED1-A8B8-D649ADD5E506@javigon.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-3-git-send-email-jens.wiklander@linaro.org>
 <20150418085747.GC29858@kroah.com>
 <FCFF5E10-0DDC-4ED1-A8B8-D649ADD5E506@javigon.com>
Message-ID: <20150418184903.GB30508@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 11:36:53AM +0200, Javier Gonz?lez wrote:
> Hi,

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

> We have discussed and implemented an in-kernel interface for the driver.
> However, we need to agree on that interface with the kernel submodules that
> can be interested in using it (e.g., IMA, keyring). We though it was easier
> to have a framework in place before taking this space. This makes sense
> since a TEE driver will be, as for today, mostly used by user space.
> applications.

No, please provide a "real" solution, just providing a framework that no
one uses means that I get to delete it from the kernel tree the next
release, and I doubt you want that :)

Please do all of the work here, as odds are, what you need in the end
will be different from what you have proposed here.

thanks,

greg k-h
