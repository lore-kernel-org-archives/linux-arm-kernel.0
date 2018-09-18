From: bp@alien8.de (Borislav Petkov)
Date: Tue, 18 Sep 2018 09:53:11 +0200
Subject: [PATCH v7 1/7] edac: synopsys: Fix code comments and naming
 convention
In-Reply-To: <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-2-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180918075311.GB22202@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:54:59PM +0530, Manish Narani wrote:
> Update the comments in the Synopsys EDAC driver. Minor changes to function
> names and return types are also included.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 176 ++++++++++++++++++++-----------------------
>  1 file changed, 80 insertions(+), 96 deletions(-)

So this patch does a bunch of things together and should be split into:

* functional changes like code cleanup
* functions renaming
* comments cleanup

Maybe in that order.

This way you'll have one logical set of changes per patch and review
will be almost trivial.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
