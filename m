From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 09 Dec 2016 20:23:51 +0800
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <CAKv+Gu_XsKU6godiQC7wVDmCUC9bZL=kv0RarTOTATuQ5EZp2Q@mail.gmail.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <bc099ca6-d927-3eb6-438c-291a66ecf5f9@huawei.com>
 <CAKv+Gu_XsKU6godiQC7wVDmCUC9bZL=kv0RarTOTATuQ5EZp2Q@mail.gmail.com>
Message-ID: <584AA257.3080608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2016 08:19 PM, Ard Biesheuvel wrote:
> On 9 December 2016 at 12:14, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> Hi Robert,
>> We have merged your patch to 4.9.0-rc8, however we still meet the similar problem
>> on our D05 board:
>>
>
> To be clear: does this issue also occur on D05 *without* the patch?

It boots ok on D05 without this patch.

But I think the problem Robert described in the commit message is
still there, just not triggered in the boot. we met this problem
when having LTP stress memory test and hit the same BUG_ON.

Thanks
Hanjun
