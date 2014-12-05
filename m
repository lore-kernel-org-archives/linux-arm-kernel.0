From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 05 Dec 2014 10:48:35 +0000
Subject: [PATCH v12 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <548189D4.3010907@huawei.com>
References: <1417671172-52915-1-git-send-email-wangnan0@huawei.com>
 <1417671360-53399-1-git-send-email-wangnan0@huawei.com>
 <1417710073.2239.10.camel@linaro.org> <5481289E.4060504@huawei.com>
 <1417774227.2232.1.camel@linaro.org> <548189D4.3010907@huawei.com>
Message-ID: <1417776515.2232.3.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-12-05 at 18:32 +0800, Wang Nan wrote:
> Both your and mine failure are related to ldrd/h instruction. What
> about your second failed testcase?

Can't remember exactly, but it was some instruction that didn't access
memory I remember that much.

I've also just run the tests on an A9 CPU and get the Oops on the nop
after the 'wfi' instruction test. So looks like the problem isn't
related to particular test cases.

-- 
Tixy
