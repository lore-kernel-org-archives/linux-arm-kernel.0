From: tsoni@codeaurora.org (Trilok Soni)
Date: Tue, 11 Sep 2018 11:17:40 -0700
Subject: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
In-Reply-To: <20180911174643.26199-1-s-anna@ti.com>
References: <20180911174643.26199-1-s-anna@ti.com>
Message-ID: <2d904881-ec72-dd68-48ff-b8307642bc63@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

>   
>   #define MSG		"hello world!"
> -#define MSG_LIMIT	100
> +
> +static int count = 100;
> +module_param(count, int, 0644);

I thought Greg KH doesn't want any new code to have module_param call, 
right? Are we Ok here or I am missing something here.

-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
