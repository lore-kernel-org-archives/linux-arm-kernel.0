From: bp@alien8.de (Borislav Petkov)
Date: Mon, 3 Sep 2018 21:18:15 +0200
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <003201d44397$8eb02c20$ac108460$@codeaurora.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
 <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com>
 <5B891308.40407@huawei.com>
 <003201d44397$8eb02c20$ac108460$@codeaurora.org>
Message-ID: <20180903191814.GG10249@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 09:05:29AM -0600, wufan wrote:
> Thanks tanxiaofei!
> 
> Boris/James, are you OK to sign off, or you want to see more tests on 
> this patch? 

Please do not top-post.

Now, I don't have any problems with it - I'm still sceptical as the
firmware is a stinking pile but if we cannot find a broken case, I guess
we can take this one for a spin and revert it if there's trouble down
the road.

Unless James has objections.

Then, you sent a v2 here:

https://lkml.kernel.org/r/1535654266-40053-1-git-send-email-wufan at codeaurora.org

and you've received a bunch of Reviewed-by's and Tested-by's and a
couple of new comments.

Incorporate *all* of those and send me a v3.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
