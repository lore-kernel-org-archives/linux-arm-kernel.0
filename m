From: s-anna@ti.com (Suman Anna)
Date: Mon, 1 Oct 2018 16:09:18 -0500
Subject: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
In-Reply-To: <2d904881-ec72-dd68-48ff-b8307642bc63@codeaurora.org>
References: <20180911174643.26199-1-s-anna@ti.com>
 <2d904881-ec72-dd68-48ff-b8307642bc63@codeaurora.org>
Message-ID: <2134784b-8645-cbf3-41af-7c9cc800a146@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trilok,

On 09/11/2018 01:17 PM, Trilok Soni wrote:
> Bjorn,
> 
>> ? ? #define MSG??????? "hello world!"
>> -#define MSG_LIMIT??? 100
>> +
>> +static int count = 100;
>> +module_param(count, int, 0644);
> 
> I thought Greg KH doesn't want any new code to have module_param call,
> right? Are we Ok here or I am missing something here.

Can you point me to the thread where this was discussed/decided?

regards
Suman
