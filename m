From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Sat, 18 Apr 2015 11:36:53 +0200
Subject: [RFC PATCH 2/2] tee: add OP-TEE driver
In-Reply-To: <20150418085747.GC29858@kroah.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-3-git-send-email-jens.wiklander@linaro.org>
 <20150418085747.GC29858@kroah.com>
Message-ID: <FCFF5E10-0DDC-4ED1-A8B8-D649ADD5E506@javigon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
We have discussed and implemented an in-kernel interface for the driver.
However, we need to agree on that interface with the kernel submodules that
can be interested in using it (e.g., IMA, keyring). We though it was easier
to have a framework in place before taking this space. This makes sense
since a TEE driver will be, as for today, mostly used by user space.
applications.

Best,
Javier

> On 18 Apr 2015, at 10:57, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Fri, Apr 17, 2015 at 09:50:57AM +0200, Jens Wiklander wrote:
>> Adds mostly stubbed OP-TEE driver which also can be compiled as a
>> loadable module.
> 
> Please provide a "real" driver, so that we can see how this is all going
> to work.  Otherwise it's not really that useful to create some framework
> that nothing in-kernel is going to use.
> 
> thanks,
> 
> greg k-h

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150418/603813a0/attachment.sig>
