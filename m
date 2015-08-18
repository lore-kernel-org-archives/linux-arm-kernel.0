From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 18 Aug 2015 11:10:16 -0700
Subject: [PATCH v3 3/3] mtd: add SMEM parser for QCOM platforms
In-Reply-To: <1439855266-26242-4-git-send-email-mathieu@codeaurora.org>
References: <1439855266-26242-1-git-send-email-mathieu@codeaurora.org>
 <1439855266-26242-4-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150818181016.GU13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 17 Aug 16:47 PDT 2015, Mathieu Olivari wrote:

> On QCOM platforms using MTD devices storage (such as IPQ806x), SMEM is
> used to store partition layout. This new parser can now be used to read
> SMEM and use it to register an MTD layout according to its content.

Looks good, but the license string should be "GPL v2" (lower case v).
Just as a hint...I made checkpatch warn you about that a while back ;)

The rest is

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

[..]

> +
> +MODULE_LICENSE("GPL V2");

Regards,
Bjorn
