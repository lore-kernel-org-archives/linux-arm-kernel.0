From: bp@suse.de (Borislav Petkov)
Date: Wed, 18 Oct 2017 11:06:49 +0200
Subject: [PATCH v5 2/2] acpi: apei: Add SEI notification type support for
 ARMv8
In-Reply-To: <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <1508227341-15651-2-git-send-email-gengdongjiu@huawei.com>
 <20171017170635.qb4sqyrsnndgbuni@pd.tnic>
 <0bcba052-700b-5ee8-88fc-aaf8cc6b1d37@huawei.com>
Message-ID: <20171018090649.e7qgdf2dwmr7yxc3@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 01:00:44PM +0800, gengdongjiu wrote:
> SError is System Error, which is a asynchronous exception in the Internal CPU.
> 
> In the ARM RAS Extension, there are mainly two type abort for CPU:
> SEA(Synchronous External Abort)
> SEI(SError Interrupt)

And you're not writing it out as "System Error" because ...?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
