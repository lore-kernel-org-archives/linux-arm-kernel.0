From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 3 Sep 2015 10:02:33 -0700
Subject: [PATCH v2 5/8] soc: qcom: smd: Remove use of VLAIS
In-Reply-To: <1441234011-4259-6-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
 <1441234011-4259-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150903170233.GR13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 02 Sep 15:46 PDT 2015, Stephen Boyd wrote:

> Usage of VLAIS prevents clang from compiling this file, and it
> also opens us to the possibility of allocating a large structure
> on the stack to the point that we blow past the limit of the
> kernel stack. Remove the VLAIS and allocate a structure on the
> heap with kmalloc so that we're safer and more clang friendly.
> 
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
