From: bcm@fixthebug.org (Christian Daudt)
Date: Fri, 8 Nov 2013 13:35:04 -0800
Subject: [RESEND PATCH v2 1/6] ARM: dts: Declare clocks as fixed on
 bcm11351
In-Reply-To: <CAAYSxhoHYaFzcoxEAJrNb6d8n1aKGDN68K3eekRT22s0h7960w@mail.gmail.com>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
 <1381960030-1640-2-git-send-email-tim.kryger@linaro.org>
 <527CC2A5.7080000@linaro.org>
 <CAAYSxhoHYaFzcoxEAJrNb6d8n1aKGDN68K3eekRT22s0h7960w@mail.gmail.com>
Message-ID: <CAEPRUYoXHJbST9Yg8=-YT_C9Lhj+VQA734quw=++pLTGaWXRyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I can pick up the dt related changes as long as the other code works
as-is both with and without the change (i.e. no backwards/forwards
compatibility issues). If this must be introduced alongside the other
changes, then the patches will have to be reworked to break them up by
subtree so they can go in atomically.
 csd


On Fri, Nov 8, 2013 at 11:42 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Fri, Nov 8, 2013 at 2:53 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>
>> I was wondering what is the status of this patchset ?
>>
>> The patchset touches different areas maintained by different people. Through
>> what tree do you expect this patchset to be merged ??
>
> Hi Daniel,
>
> I plan to send an updated version soon to address some concerns raised by Mark.
>
> Once all the maintainers are satisfied and provide their acks, I would
> like Christian to take the series into his tree.
>
> I expect Christian will have a few other Broadcom DTS file changes in
> his tree so sending the series through him should make it easier to
> avoid/manage conflicts.
>
> Christian, would that work for you?
>
> Thanks,
> Tim Kryger
