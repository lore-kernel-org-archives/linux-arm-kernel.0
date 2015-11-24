From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 24 Nov 2015 00:35:07 -0700
Subject: [PATCH v3 57/62] hvm/params: Add a new dilivery type for
 event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1447753261-7552-58-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-58-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5654213B02000078000B832D@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a new dilivery type:
> val[63:56] == 3: val[15:8] is flag: val[7:0] is a PPI.
> To the flag, bit 0 stands the interrupt mode is edge(1) or level(0) and
> bit 1 stands the interrupt polarity is active low(1) or high(0).
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Please sync up with Andrew's cleaning up of the modified comment;
I definitely will want that to go in first.

Jan
