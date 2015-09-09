From: dhdang@apm.com (Duc Dang)
Date: Wed, 9 Sep 2015 14:47:10 -0700
Subject: [GIT PULL] ARM64: APM X-Gene 1 and X-Gene 2 DTS updates for 4.3
In-Reply-To: <CAOesGMi4PpeBa7_oT5CkitVx2uc7z7NwX2BWc7VBGgsrvZ82dg@mail.gmail.com>
References: <CADaLNDkKt_0O81CnaBf6pEvHQYAkJ177PqyvvEA_MS_FMREE_A@mail.gmail.com>
 <1706053.LCOS62kkie@wuerfel>
 <CAOesGMi4PpeBa7_oT5CkitVx2uc7z7NwX2BWc7VBGgsrvZ82dg@mail.gmail.com>
Message-ID: <CADaLNDmtUUHEJjUi320oV24KaDGmrfcbGeqnd9DC9HJgkr_D-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2015 at 2:41 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Sep 9, 2015 at 2:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 08 September 2015 16:17:38 Duc Dang wrote:
>>> On Tue, Sep 1, 2015 at 3:20 PM, Duc Dang <dhdang@apm.com> wrote:
>>> > Hi Olof,
>>> >
>>> > The following changes since commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:
>>> >
>>> >   Linux 4.2-rc5 (2015-08-02 18:34:55 -0700)
>>> >
>>> > are available in the git repository at:
>>> >
>>> >   https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.3-1
>>> >
>>> > for you to fetch changes up to 28376033baac2f0c2892eafd471b92ab28385d91:
>>> >
>>> >   arm64: dts: Add poweroff device nodes for APM X-Gene 2 platform
>>> > (2015-09-01 13:42:16 -0700)
>>> >
>>> > ----------------------------------------------------------------
>>> > X-Gene 1 and X-Gene 2 platforms DTS changes queued for 4.3
>>> >
>>
>>>
>>> Please let me know if you have any comment for this pull request.
>>
>> I don't know what you had previously discussed, but we tend to not take
>> pull requests for new code during the merge window or the time immediately
>> before it, so this will normally get merged for 4.4 after 4.3-rc1 is out.
>>
>> Unless Olof has previously agreed to merge the changes as a very late
>> fixup, please rebase the branch on 4.3-rc1 and submit it again next
>> week.
>>
>> We've long had discussions about whether to allow DT changes past the
>> start of the merge window, in particular for new hardware support, but
>> we have yet to come up with an official policy for it (unless there
>> is now one that I have missed while I was on parental leave).
>
>
> Yeah, sorry, this came in too late. I know it took some time to setup
> the tree and get things sorted, and I was hoping to pick it up in the
> late batch but that didn't happen.
>
> Please resend when -rc1 is out and we'll queue it for the next merge window.
>
>
> -Olof

Thanks for your response, Olof and Arnd.

I will rework the tree for 4.4 when 4.3-rc1 become available.

-- 
Duc Dang.
