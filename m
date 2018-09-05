From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Wed, 5 Sep 2018 17:50:28 +0300
Subject: [PATCH v9 0/8] Introduce on-chip interconnect API
In-Reply-To: <20180905093620.6d9162ca@canb.auug.org.au>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
 <20180905093620.6d9162ca@canb.auug.org.au>
Message-ID: <fe9f3e91-93f9-d7d5-1643-dc09543e2850@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 09/05/2018 02:36 AM, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 4 Sep 2018 15:54:27 +0530 Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>
>> I'm currently reviewing this patchset (long overdue), but considering
>> that we haven't added any major new features to the framework for the
>> last couple of revisions, can you get this patchset merged into
>> linux-next to see how things shake out there? We've had this merged
>> branch merged into a CI build on kernelci for a while now w/o any
>> major incident so we should increase its exposure.
>>
>> You could ask Stephen Rothwell if he'll accept the a branch directly
>> from you or he needs an upstream maintainer (GregKH?) to carry it.
> 
> Since it appears to have been well reviewed and tested, I can take it
> if you send me a git URL and the names of contacts in case of issues
> with the branch.  Once Greg has merged it, I will try to drop it again
> (unless you think there will be an ongoing reason to keep it in
> linux-next separately), but a prompting email would also be nice in
> case I forget.

Thank you! Below is the git URL to pull from and you can use my e-mail
as contact for any issues.

git://git.linaro.org/people/georgi.djakov/linux.git#icc-next

I expect this to be a continuing effort with some upcoming users of this
API, so i plan to maintain this branch and occasionally put some
reviewed/tested patches to get wider integration testing. But let's see
what happens now.

In any case, if this increases your burden, feel free to drop it.

Thanks,
Georgi
