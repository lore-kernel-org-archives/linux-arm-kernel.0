From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Jun 2018 11:54:15 +0100
Subject: [PATCH] driver core: add a debugfs entry to show deferred devices
In-Reply-To: <20180619225145.GA23389@kroah.com>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
Message-ID: <20180620105415.GC6242@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 07:51:45AM +0900, Greg Kroah-Hartman wrote:

> And what is the use of this file?  What can you do with this
> information?  Who is going to use it?  Don't we have other deferred
> probe debugging somewhere else?

Pretty much all we have right now is kernel log messages, and people
keep trying to suppress those as they're quite noisy sometimes.  Ideally
the device dependency stuff will reduce that problem but I'm not sure
how that's getting on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180620/d8d6e36a/attachment.sig>
