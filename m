From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Tue, 23 Sep 2014 15:46:37 +0200
Subject: FIX Me in pgtable.h
In-Reply-To: <54216FC9.5060605@gmail.com>
References: <54216FC9.5060605@gmail.com>
Message-ID: <542179BD.9070406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.09.2014 15:04, nick wrote:
> Greetings Arm Maintainers,
> I am wondering about the fix me in pgtable.h for define kern_addr_valid and how to set it to a correct
> value as you state that this needs to be fixed as the defined macro is still 1. This is probably incorrect
> and should be changed.

Dear Nick Krause,

Before you start coding - do you have necessary ARM-based hardware to 
test your changes?

Changing email won't remove LKML archives...

Best regards,
Krzysztof
