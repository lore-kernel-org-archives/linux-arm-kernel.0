From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 3 Sep 2015 10:03:27 -0700
Subject: [PATCH v2 8/8] regulator: qcom_smd: Handle big endian CPUs
In-Reply-To: <1441234011-4259-9-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
 <1441234011-4259-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150903170327.GU13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 02 Sep 15:46 PDT 2015, Stephen Boyd wrote:

> The smd rpm structures are always in little endian, but this
> driver is not capable of being used on big endian CPUs. Annotate
> the little endian data members and update the code to do the
> proper byte swapping.
> 
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
