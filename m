From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 12 Jul 2016 11:03:32 -0400
Subject: [PATCH] media: s5p-mfc Fix misspelled error message and
 checkpatch errors
In-Reply-To: <1468276740-1591-1-git-send-email-shuahkh@osg.samsung.com>
References: <1468276740-1591-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <8dd68d9b-9455-d593-dc0f-c269c778b961@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On 07/11/2016 06:39 PM, Shuah Khan wrote:
> Fix misspelled error message and existing checkpatch errors in the
> error message conditional.
> 
> WARNING: suspect code indent for conditional statements (8, 24)
>  	if (ctx->state != MFCINST_HEAD_PARSED &&
> [...]
> +               mfc_err("Can not get crop information\n");
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---

Patch looks good to me. Maybe is better to split the message and checkpatch
changes in two different patches. But I don't have a strong opinion on this:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
