From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 18 Apr 2015 10:57:47 +0200
Subject: [RFC PATCH 2/2] tee: add OP-TEE driver
In-Reply-To: <1429257057-7935-3-git-send-email-jens.wiklander@linaro.org>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20150418085747.GC29858@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 09:50:57AM +0200, Jens Wiklander wrote:
> Adds mostly stubbed OP-TEE driver which also can be compiled as a
> loadable module.

Please provide a "real" driver, so that we can see how this is all going
to work.  Otherwise it's not really that useful to create some framework
that nothing in-kernel is going to use.

thanks,

greg k-h
