From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Sep 2018 23:58:51 +0200
Subject: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
In-Reply-To: <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
 <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
Message-ID: <20180924215850.GD18592@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 11:02:54AM -0700, Jae Hyun Yoo wrote:
> On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
> > +- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
> > +			  multi-master is set, defaults to 100 ms when not
> > +			  specified.
> 
> Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
> property.

No need. This binding is not a HW description, so not a DT property in
my book. I still don't understand: Your IP core in master mode does not
have a BUSY bit or similar which detects when a START was detected and
clears after a STOP?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180924/cae32de3/attachment.sig>
