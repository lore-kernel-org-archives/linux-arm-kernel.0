From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Jul 2012 22:58:46 -0700
Subject: [GIT PULL] SPEAr platform fixes over 3.5-rc7
In-Reply-To: <20120718052911.GQ1994@localhost.localdomain>
References: <20120717130150.GM1994@localhost.localdomain>
 <CAOesGMgHFrydxO-eJiuTL2yLKmVZXMcqiPhnBZQgbd=YcXD-Mg@mail.gmail.com>
 <20120718052911.GQ1994@localhost.localdomain>
Message-ID: <CAOesGMhgdQKhfdZWq32ideX-m2-_Y=ANxBF+eMwgxFCkZpc_iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 10:29 PM, Shiraz Hashim <shiraz.hashim@st.com> wrote:
> Hi Olof,
>
> On Tue, Jul 17, 2012 at 08:43:34PM -0700, Olof Johansson wrote:
>> Hi Shiraz,
>>
>> I see that every commit in that branch is done by you, but not a
>> single one has a Signed-off-by by you. Please fix that, it's important
>> to track the history of how code is introduced to the kernel.
>>
>> Also, we are _very_ late in the 3.5 release cycle now. Only truly
>> critical fixes can go in (3.5 is likely to come out by the weekend). I
>> have some comments about the patches below.
>>
>> In general, to make our life easier, please make sure the commit
>> message for the patch describes why the fix is needed when it's not
>> obvious.
>>
>> I'll wait with pulling until you have a chance to fix up your branch
>> based on the below comments. Please make sure you do it with extreme
>> expediency though, or chances are it'll miss 3.5.
>
> I have tried to fix all points mentioned by you and updated the spear
> fixes branch.
>
> The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:
>
>   Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)
>
> are available in the git repository at:
>
>   http://git.stlinux.com/spear/linux-2.6.git for-3.5-spear-fixes

Thanks for the quick turnaround. I've pulled this branch into fixes
and will send it up to Linus tonight or tomorrow morning once the at91
branch has been sorted out too.

One remaining nit: Your signed-off-by lines should be the very last
line, since you were the last person to touch the patch. You would
normally add Acked-by lines that came in above your own S-o-b, not
below. Please keep that in mind for future patches (if you use git am
-s then git will handle this automatically).


-Olof
