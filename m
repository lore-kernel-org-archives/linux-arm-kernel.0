From: agraf@suse.de (Alexander Graf)
Date: Fri, 18 Mar 2016 16:55:26 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160318154918.GA1595@yury-N73SV>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de> <20160225202855.GD16123@yury-N73SV>
 <56EBD84D.2060009@huawei.com> <20160318154918.GA1595@yury-N73SV>
Message-ID: <56EC24EE.6020803@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18.03.16 16:49, Yury Norov wrote:
> On Fri, Mar 18, 2016 at 06:28:29PM +0800, Zhangjian (Bamvor) wrote:
>>
>> For the glibc part, I found that there are 11 patches of ilp32 in top,
>> but the original 28 patches of ilp32 is not in the top, there are more
>> than 900 patches between them(referece the list below). Are you
>> willing rebase all the ilp32 relative patches. It is very useful for
>> reviewing and debugging.  I saw andrew request the account in glibc,
>> maybe it has already been in processs?).
>>
> 
> I already told there's mess there, and I'd prefer to make things work
> first and then do cleanup. 

So how is progress going overall? The last submission I've seen is
already 2 months ago. Are there particular bits holding you up?


Alex
