From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 21 Sep 2012 16:00:27 +0800
Subject: [PATCH] ARM: mmp: using for_each_set_bit to simplify the code
In-Reply-To: <CAMPhdO8G_GzOBKB=pdWgKv5GxnYoSNC2mRVwpHYqz4d648pwkA@mail.gmail.com>
References: <CAPgLHd-ac3JYu4SEQd0pPO-YBW4kM+DqcjHs3QzPdLWqc+CXfw@mail.gmail.com>
 <CAMPhdO8G_GzOBKB=pdWgKv5GxnYoSNC2mRVwpHYqz4d648pwkA@mail.gmail.com>
Message-ID: <CAN1soZxkFXc4o+Yjn1hpmM_WMjH8ULf9LuaWA3D=d1aHj97JrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:23 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Sep 14, 2012 at 10:30 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Using for_each_set_bit() to simplify the code.
>>
>> spatch with a semantic match is used to found this.
>> (http://coccinelle.lip6.fr/)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Great API, this is good. Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
Applied

Thanks
Haojian
