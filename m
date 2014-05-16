From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 May 2014 10:27:48 -0700
Subject: [GIT PULL] ARM: STi: DT changes for v3.16
In-Reply-To: <5376212D.5010209@st.com>
References: <5375D1A4.2040205@st.com> <5375DECA.3050600@linaro.org>
 <5376212D.5010209@st.com>
Message-ID: <CAOesGMi_pS2d+EqcNA2Nea_BGGz7NPPOzmvU39spiKjPfNwBRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 7:31 AM, Maxime Coquelin <maxime.coquelin@st.com> wrote:
> Hi,
>
>
> On 05/16/2014 11:47 AM, Srinivas Kandagatla wrote:
>>
>>
>>
>> On 16/05/14 09:51, Maxime Coquelin wrote:
>>>
>>> Hi Olof, Kevin and Arnd,
>>>
>>> Please consider these STi DT updates for v3.16.
>>>
>>> Note that two reset patches are part of this pull request, in order to
>>> avoid compilation breakage.
>>> Adding these two patches in this pull request has been accepted by
>>> Philipp Zabel.
>>>
>>> The following changes since commit
>>> 2542f928b2131a0367e50a4390afc12084cc4cc4:
>>>
>>>    Merge tag 'renesas-dt2-for-v3.16' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt
>>> (2014-05-05 18:44:12 -0700)
>>>
>>
>> renesas ??
>
>
> As discussed on IRC, I have based this pull request on top of arm_soc's
> next/dt branch, whereas I should have based in top of v3.15-rc1.
>
> Arnd, Olof, Kevin, is it fine for this time?
> Or should I resend the two pull requests based on top of v3.15-rc1?
> Either ways are fine to me, just let me know!

No, this is unfortunately not something we can merge in. You have to
base your branch on top of an upstream -rc, not on our category
branches. Please send fresh requests.


Thanks!


-Olof
