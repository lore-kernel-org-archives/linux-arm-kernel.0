From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jan 2014 11:31:46 -0800
Subject: [PATCH v2 0/7] Allow MSM DT platforms to be built multi-platform
In-Reply-To: <52C70698.2030004@codeaurora.org>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <201401021913.25920.arnd@arndb.de>
 <52C70698.2030004@codeaurora.org>
Message-ID: <CAOesGMiFixweRT1R-y2Cxvx+p6tzf3Qr-TaAwqDBCgB=Ge8FfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 10:51 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/02/14 10:13, Arnd Bergmann wrote:
>> On Monday 30 December 2013, Stephen Boyd wrote:
>>> These patches allow the DT based MSM platforms to be built as part of the
>>> multi-platform kernel. I need acks from Chris Ball on the mmc patch and
>>> Rob/Dave on the drm patch. I dropped Arnd's ack on patch 6 because I've
>>> rebased that patch on top of the patchset David sent out (which this is in
>>> reply to). The rebase was fairly minor and the new patch for drm/msm is
>>> trivial. Please consider for v3.14.
>> Just for the record, I'm definitely happy with the way this is turning out,
>> don't see my question on the serial driver as a NAK. I assume we will apply
>> the patches for 3.14, but I first want to have a better understanding on
>> where we are with the stuff that is already queued up for 3.14.
>>
>
> It would be great if we could get these patches in for 3.14. Now that
> Olof has applied the collection of patches that David sent, these
> patches should apply cleanly on top of arm-soc.git qcom/soc. Can you
> apply them directly to the arm-soc tree?

Yeah, we'll get to it in a bit.


-Olof
