From: wangnan0@huawei.com (Wang Nan)
Date: Thu, 5 Mar 2015 10:06:49 +0800
Subject: [PATCH 3/3] early kprobes: x86: don't try to recover ftraced
 instruction before ftrace get ready.
In-Reply-To: <54F7B702.2000403@huawei.com>
References: <54F69F45.3000704@hitachi.com>
 <1425468122-54515-1-git-send-email-wangnan0@huawei.com>
 <54F72438.3010405@hitachi.com> <54F7B702.2000403@huawei.com>
Message-ID: <54F7BA39.3030204@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 9:53, Wang Nan wrote:
>> 	...
>> > 
>>> >>  	/* kprobe is available. */
>>> >>  	KP_STG_AVAIL,
>> > 
>> >  KP_STG_EARLY is better, isn't it? :)
> Sure. I will change it.
> 

Sorry, I remembered the reason why I call it KP_STG_AVAIL. What about .config
turns off CONFIG_EARLY_KPROBES? In fact, in my WIP v5 series, the progress valued
are introduced earlier than early kprobe. At that time the principle of KP_STG_EARLY
should not be created.

What do you think?

Thank you.
