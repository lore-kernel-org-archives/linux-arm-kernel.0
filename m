From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 21:03:40 +0300
Subject: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <8739124idt.fsf@deeprootsystems.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
 <8739124idt.fsf@deeprootsystems.com>
Message-ID: <20121025180339.GA18046@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 09:38:06AM -0700, Kevin Hilman wrote:
> +Paul
> 
> Felipe Balbi <balbi@ti.com> writes:
> 
> > if we allow compiler reorder our writes, we could
> > fall into a situation where dev->buf_len is reset
> > for no apparent reason.
> 
> Any chance this would help with the bug Paul found with I2C timeouts on
> beagle userspace startup?

I replied to the original thread asking the same ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/8550556d/attachment-0001.sig>
