From: yuehaibing@huawei.com (YueHaibing)
Date: Fri, 21 Sep 2018 09:33:24 +0800
Subject: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
In-Reply-To: <20180920.085055.1188796939437872993.davem@davemloft.net>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920.085055.1188796939437872993.davem@davemloft.net>
Message-ID: <83d29681-b008-9b1f-5961-e23f0174d5f4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/9/20 23:50, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Thu, 20 Sep 2018 20:32:44 +0800
> 
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, so make sure the implementation in
>> this driver has returns 'netdev_tx_t' value, and change the function
>> return type to netdev_tx_t.
> 
> I would advise you not to send so many of these changes as a group.
> 
> If one of the patches needs feedback addressed, which is already the
> case, you will have to resubmit the entire series all over again with
> the fixes.
> 

Yes, I will send it separately after test and review again.

Thank you for your advice.

> .
> 
