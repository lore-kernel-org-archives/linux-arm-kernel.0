From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Tue, 13 May 2014 13:09:00 -0400
Subject: [PATCH v9 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <CAJ5Y-eadEXyabW2r_gSsnNyT2zQr3=Dwtq-_oDeryk-h4d6kUw@mail.gmail.com>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
 <1399472847-14377-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140512091047.GB3006@e106331-lin.cambridge.arm.com>
 <CAJ5Y-eadEXyabW2r_gSsnNyT2zQr3=Dwtq-_oDeryk-h4d6kUw@mail.gmail.com>
Message-ID: <CAJ5Y-eZ1gaSPz7n44e+WuVyc=8sjyOUGNw9hDEqH1KKOP3yQRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 12 May 2014 10:02, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>
>> Which tree are you planning on merging this through? Do we need to split
>> the arm and arm64 parts?
>
> IIRC all this PSCI work originally came via Catalins tree(?). But now,
> these patches depend on a header introduced by Anups KVM patchset
> which is merged in -
> https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/log/?h=next
>
> In a previous discussion (everyone here is CC'd) with Christoffer and
> Paolo the 2nd option of the following was chosen:
>
> 1) Catalin can apply "Add common header for PSCI related defines", or
> Ashwin can resend his series with the patch at the beginning.
> Duplicate commits are fine, especially for seldom-modified files where
> they do not cause conflicts.
>
> 2) Send Anup's patchset as a pull request to both me and Catalin,
> relative to v3.16-rc1, both of us can apply it and Ashwin's series can
> be commit on top.
>
>
> To keep it simple it'd be better if it all goes via one tree, but if
> there are objections or other suggestions, I'm happy to split this up.

What is the preferred method to upstream this patchset? Would you
recommend this be split into ARM and ARM64 variants, or can it all go
via the ARM64 tree? I will then respin these accordingly, along with
the feedback from Anup and Mark.

Thanks,
Ashwin
