From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 14 Mar 2013 10:29:43 +0000
Subject: [PATCH V2] pinctrl: mvebu: prevent walking off the end of group
 array
In-Reply-To: <1363196884-20193-1-git-send-email-jason@lakedaemon.net>
References: <1362872371.3690.106.camel@shinybook.infradead.org>
 <1363196884-20193-1-git-send-email-jason@lakedaemon.net>
Message-ID: <1363256983.4853.10.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 17:48 +0000, Jason Cooper wrote:
> From: David Woodhouse <dwmw2@infradead.org>
> 
> While investigating (ab)use of krealloc, David found this bug.  It's
> unlikely to occur, but now we detect the condition and error out
> appropriately.
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> Changes from v1:
>  - correct typo (s/ nt / int /) I should've caught before sending.
> 
> David, please double check that this is as you intended.  I had to hand-jam it
> in due to some peculiarities on my side.

Looks fine; thanks.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/80874e05/attachment-0001.bin>
