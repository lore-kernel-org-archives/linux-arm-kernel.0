From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 12 Dec 2017 12:15:02 +0800
Subject: [RESEND PATCH V2] arm64: fault: avoid send SIGBUS two times
In-Reply-To: <316b5416-1268-1e9b-ae07-aa6cd31db8a8@huawei.com>
References: <20171211160536.11600-1-gengdongjiu@huawei.com>
 <316b5416-1268-1e9b-ae07-aa6cd31db8a8@huawei.com>
Message-ID: <f997bbd8-87d2-3633-e9fe-4a6d5bb23858@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/12/12 11:31, Xie XiuQi wrote:
>> +	return 0;
> It looks good to me. do_sea() has done all necessary action for SEA, so it should always return 0,
> no matter ghes_notify_sea() return true or false.
yes, it is.

> 
> Reviewed-by: Xie XiuQi <xiexiuqi@huawei.com>

Thanks XiuQi's review and comments.

> 
>>  }
