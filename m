From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Nov 2017 16:30:32 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Select RPMSG_VIRTIO as module
In-Reply-To: <20171103051442.GO28761@minitux>
References: <1507222198-5052-1-git-send-email-anup@brainfault.org>
 <20171103051442.GO28761@minitux>
Message-ID: <CAK8P3a3L2NPvcARy1+6pqbeVo=GAnTvx1F7TfgPQ5TwMwRu0-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 6:14 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Thu 05 Oct 09:49 PDT 2017, Anup Patel wrote:
>
>> The RPMSG_VIRTIO is now user selectable option so we explicitly
>> select it in multi_v7_defconfig. Till now RPMSG_VIRTIO was
>> selected by ST_REMOTEPROC=m in multi_v7_defconfig.
>>
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
>> Signed-off-by: Anup Patel <anup@brainfault.org>

Applied, thanks!

     Arnd
