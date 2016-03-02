From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 2 Mar 2016 11:28:33 +0900
Subject: [PATCH 00/19] arm64 kexec kernel patches v13
In-Reply-To: <20160302013848.GG14022@arm.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <c7575f853ccc491bb0212e025aab1cc9@NASANEXM01H.na.qualcomm.com>
 <56D5D763.4030304@codeaurora.org> <1456881475.6738.18.camel@infradead.org>
 <20160302013848.GG14022@arm.com>
Message-ID: <56D64FD1.4030900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2016 10:38 AM, Will Deacon wrote:
> On Tue, Mar 01, 2016 at 05:17:55PM -0800, Geoff Levand wrote:
>> On Tue, 2016-03-01 at 10:54 -0700, Azriel Samson wrote:
>>
>>> We have been using the kexec/kdump patches on ARM64 and would like to
>>> use them from upstream.
>>>
>>> Assuming these are not going to be in Linux-4.5, a rebased set on
>>> Linux-4.5 would be very useful.
>>
>> I'm waiting for one of two things to happen, either Marc Zyngier gives
>> an ack for the patch 'arm64: kvm: allows kvm cpu hotplug', or the arm64
>> maintainers decide they will accept my proposal to merge kexec with a
>> conditional in the Kconfig that only allows one of KVM or kexec to be
>> selected.
>
> Depending on !KVM isn't even an option as far as I'm concerned. It basically
> makes this all dead code.
>
> As for awaiting an ack on the kvm hotplug patch, afaict, Akashi was going
> to address James's comments on the last posting [1].

Come on!
I have already fixed this issue, but still waiting for Geoff rebasing his patch
as he is now a submitter of the whole patch series including kexec/kdump.
(Please note, as James suggested, some (minor) modification need be made for
rebasing onto v4.5)

>> The kexec patches have been in review for 20 months now, with only
>> minor changes in the past 15.  I don't expect much would be gained in
>> posting the kexec series again unless there is a chance they would be
>> merged.
>
> Why do you say that? v13 attracted lots of comments from a variety of
> reviewers, so the onus is on you to address that feedback and post a
> new version. Alternatively, declare that you no longer to intend to work
> on the series, and perhaps then somebody else can pick it up and finish
> the job.

*If* Geoff is no longer willing to work on upstreaming kexec stuff,
I will probably take over his task.

-Takahiro AKASHI

> Will
>
> [1] http://lkml.kernel.org/r/56A873C0.6090406 at linaro.org
>
