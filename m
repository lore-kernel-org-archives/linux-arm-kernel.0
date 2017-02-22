From: joe@perches.com (Joe Perches)
Date: Tue, 21 Feb 2017 16:30:52 -0800
Subject: [PATCH V10 07/10] efi: print unrecognized CPER section
In-Reply-To: <9b8aee3f-9ab6-121a-cad0-96a39743de55@codeaurora.org>
References: <1487188282-2568-1-git-send-email-tbaicar@codeaurora.org>
 <1487188282-2568-8-git-send-email-tbaicar@codeaurora.org>
 <58AC9093.5020303@arm.com>
 <9b8aee3f-9ab6-121a-cad0-96a39743de55@codeaurora.org>
Message-ID: <1487723452.24224.1.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-02-21 at 12:39 -0700, Baicar, Tyler wrote:
> On 2/21/2017 12:10 PM, James Morse wrote:
> > Nit: please use the "%s""section... that this file consistently uses. This means
> > this code will still work as expected when someone adds '%ss' support to printk!

Huh?

How would that work?
