From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 00:04:22 +0100
Subject: [PATCH v5 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <CAJAp7Ohgr7j7i=73R6Y_+GDa_4QZnhuPgB7AFdJGxNVJ_cVFsA@mail.gmail.com>
References: <1450442339-18765-4-git-send-email-stanimir.varbanov@linaro.org>
 <201512182111.1GLn2hxy%fengguang.wu@intel.com>
 <CAJAp7Ohgr7j7i=73R6Y_+GDa_4QZnhuPgB7AFdJGxNVJ_cVFsA@mail.gmail.com>
Message-ID: <201512220004.22548.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 December 2015, Bjorn Andersson wrote:
> I disagree with this "recommendation" as it's only outcome will be asymmetry.
> 
> I think this script should be changed to only warn if there's a single
> IS_ERR/PTR_ERR at the end of the function, not if there's a list of
> them and this would replace the last one.
> 

Agreed, looks like a false positive, and I think it's best to ignore the
warning here, but not change the script that seems reasonable in general.

	Arnd
