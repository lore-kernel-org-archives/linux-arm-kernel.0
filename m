From: schwab@suse.de (Andreas Schwab)
Date: Mon, 05 Dec 2016 11:07:26 +0100
Subject: ILP32 for ARM64: testing with glibc testsuite
In-Reply-To: <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com> (Zhangjian's
 message of "Mon, 5 Dec 2016 17:58:09 +0800")
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
 <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
 <1479419136.908.90.camel@caviumnetworks.com>
 <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
Message-ID: <mvmeg1mn0yp.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dez 05 2016, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> wrote:

> Is there some progresses on it? We could collabrate to fix those issues.

All the elf/nptl/rt fails should be fixed by the recent binutils fixes.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
