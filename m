From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 21 Jan 2016 22:14:48 +0100
Subject: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
In-Reply-To: <20160121194126.GB13448@amd>
References: <20160121184234.GA17679@amd> <20160121191525.GA26215@earth>
 <20160121194126.GB13448@amd>
Message-ID: <20160121211447.GA4984@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 21, 2016 at 08:41:26PM +0100, Pavel Machek wrote:
> Hmm. It looks like 7fdec82af6a does not yet contain 88025632515a. Let
> me try to add that fix, instead...

Right, your checkout does not contain the power supply
pull request. I think it's unlikely, that the patch will
fix your issue.

Since there are no other power supply changes between 4.4 and your
checkout, the next most likely candidate is the usb tree (which has
been merged before the commit you mentioned).

> > P.S.: No need to Cc me two times and when you update your
> > script/contacts, please use sre at kernel.org :)
> 
> Address book updated :-)

Thanks.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/52841701/attachment.sig>
