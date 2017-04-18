From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 18 Apr 2017 09:27:29 +0800
Subject: [PATCH v8 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <9556e737-a9d8-f751-2872-6fabce86fa48@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <1484744105-53140-11-git-send-email-guohanjun@huawei.com>
 <838d8504-b6f0-2475-f4b1-9761ecd9f573@codeaurora.org>
 <9556e737-a9d8-f751-2872-6fabce86fa48@codeaurora.org>
Message-ID: <58F56B81.3090608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

On 2017/4/18 6:01, Sinan Kaya wrote:
> On 4/17/2017 5:44 PM, Sinan Kaya wrote:
>> Any idea what happened to the change in this function during merge?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ae7c18380495ac5c14a614fdb6c452c3bf9148ac
>>
> I realized that there is a V9 out there. I'm catching up with the work. 
>
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-4.12&id=e6db07d0f3b6da1f8cfd485776bfefa4fcdbfc45
>
> seems to be fixing the issue. 

Patches were merged via two trees:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=irq/core
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core&ofs=50

So please try to merge those two trees and have a try (we tested
those patches on our platform and works), if any issues please let
me know.

Thanks
Hanjun
