From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 7 Dec 2016 02:52:06 +0100
Subject: [PATCH 00/16] FSI device driver introduction
In-Reply-To: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <20161207015206.5ar7exbfs353aram@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Tue, Dec 06, 2016 at 06:14:21PM -0600, Chris Bostic wrote:
> [...]
>
> Introduction of the IBM 'Flexible Support Interface' (FSI) bus device
> driver. FSI is a high fan out serial bus consisting of a clock and a serial
> data line capable of running at speeds up to 166 MHz.
> 
> [...]

I would expect, that this information is added to Documentation/
and there should be Documentation/ABI/<stable or testing>/sysfs-bus-fsi

P.S.: I'm not sure, why I'm Cc'd.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/fdc6ee6c/attachment.sig>
