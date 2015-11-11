From: schwab@suse.de (Andreas Schwab)
Date: Wed, 11 Nov 2015 09:44:16 +0100
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <5642EB69.9080302@huawei.com> (Zhangjian's message of "Wed, 11
 Nov 2015 15:16:57 +0800")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <mvm7flw3cfu.fsf@hawking.suse.de>
 <CA+=Sn1n4-mdTvyiXKpVj9509MrJWGpCeWdGJWcTSU9n2R8PVkg@mail.gmail.com>
 <20151105221842.GA30634@yury-N73SV> <mvmpozj1ofe.fsf@hawking.suse.de>
 <5642EB69.9080302@huawei.com>
Message-ID: <mvmmvulylgf.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> writes:

> Hi, Andreas
>
> On 2015/11/9 18:01, Andreas Schwab wrote:
>> Yury Norov <ynorov@caviumnetworks.com> writes:
>>
>>> This is what I run:
>>> https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t
>>
>> Thanks, rebootstrapping openSUSE Factory now.
> Where could I find them for testing? I could not find them in your
> obs[1].

It's built in a separate OBS instance, so it's not available publicly
yet.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
