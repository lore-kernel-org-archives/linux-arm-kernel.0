From: ljchen999@gmail.com (Lijun Chen)
Date: Fri, 19 Sep 2014 16:11:25 -0400
Subject: How to enable ETM/ETB on Qualcom chipset
In-Reply-To: <CANLsYkyB=c4cyp2v+5+k7TyQdO+U50p1uKRgqtxobACLsk7+Qw@mail.gmail.com>
References: <loom.20140915T174010-341@post.gmane.org>
 <CANLsYkyB=c4cyp2v+5+k7TyQdO+U50p1uKRgqtxobACLsk7+Qw@mail.gmail.com>
Message-ID: <CAPDfaDva=uPn1zVymjvL8MYVBLPRnu-OCMYYHiprUqMz+w3LzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resent with plain text mode.

Thanks, Mathieu.

I will keep monitoring the following links. BTW, is it going to be
supported in AOSP L-series?

Regards,
Lijun

On Thu, Sep 18, 2014 at 8:37 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> HW assisted tracing is currently not supported upstream on a core like
> the 8974.  There is currently a lot of work being done to change that
> but things aren't finished yet.
>
> Support for the 8974 can be found here [1] and here [2] as work in progress.
>
> For a free trace decoding "ptm2human" does a pretty good job.  Tools
> like DS-5 and Trace32 will work flawlessly.
>
> Mathieu
>
> [1]. https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/log/?h=LNX.LA.3.7.1_rb3.2
> [2]. https://git.linaro.org/kernel/coresight.git
>
> On 15 September 2014 09:49, Lijun Chen <ljchen999@gmail.com> wrote:
>> Hi,
>>
>> Anybody used ETM/ETB on Qualcomm, e.g. 8974? Which CONFIGs need to be
>> turned on? And how to decode the buffer afterwards?
>>
>> Thanks,
>> Lijun
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
