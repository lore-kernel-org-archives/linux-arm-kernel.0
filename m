From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Mar 2015 13:46:31 +0100
Subject: [PATCH 1/2] of: base: add function to get highest id of an alias
 stem
In-Reply-To: <1426177093-26820-2-git-send-email-wsa@the-dreams.de>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
 <1426177093-26820-2-git-send-email-wsa@the-dreams.de>
Message-ID: <20150318124631.GB3580@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 05:17:58PM +0100, Wolfram Sang wrote:
> I2C supports adding adapters using either a dynamic or fixed id. The
> latter is provided by aliases in the DT case. To prevent id collisions
> of those two types, install this function which gives us the highest
> fixed id, so we can then let the dynamically created ones come after
> this highest number.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/7355ea45/attachment.sig>
