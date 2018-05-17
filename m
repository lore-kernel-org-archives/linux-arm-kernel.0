From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 May 2018 08:54:49 +0200
Subject: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
Message-ID: <20180517065449.GA13589@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 12:15:08PM -0500, Jeremy Linton wrote:
> Hi Greg,
> 
> Have you had a chance to look at the cachinfo parts of this patch?

Nope :)

I didn't write that, and while it is dumped in the driver core section
of the kernel, I know nothing about it.  If you get an ack from Sundeep
for this, which you did, that's fine with me, merge away!

thanks,

greg k-h
