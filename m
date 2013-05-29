From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 May 2013 16:24:55 +0530
Subject: [PATCH] cpufreq: MAINTAINERS: Add git tree path for ARM specific
 updates
In-Reply-To: <1369824422.22004.101.camel@joe-AO722>
References: <aab5b5dc92b960e81e8fd1975eba81234a4ecac8.1369817795.git.viresh.kumar@linaro.org>
 <1369824422.22004.101.camel@joe-AO722>
Message-ID: <CAKohpomz4qOmhy-VRb2n0CY7YOr0vP3EGo88iXBhm2MzsJ8rrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2013 16:17, Joe Perches <joe@perches.com> wrote:
> On Wed, 2013-05-29 at 16:10 +0530, Viresh Kumar wrote:
>> ARM specific patches would be
>> Applied by me now. Rafael will pull in these changes from time to time (at
>> rc's).
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -2216,6 +2216,7 @@ L:      cpufreq at vger.kernel.org
> []
>>  T:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>> +T:   git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
>
> please prefix these with git
>
> T:      git git://git.etc...
>
> Every other T: git entry does.
>

Thanks for reporting it.. below commit must be fixing it..
@Rafael: attached for you to apply.

----------x-------------------x------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 May 2013 12:23:14 +0530
Subject: [PATCH] cpufreq: MAINTAINERS: Add git tree path for ARM specific
 updates

To reduce cpufreq maintenance load on Rafael, ARM specific patches would be
Applied by me now. Rafael will pull in these changes from time to time (at
rc's). Additionally I would be sending him pull request for every merge window
and rc's (for fixes).

Web interface of my tree is present here:

https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=summary

Branch names would be: cpufreq-next and cpufreq-fixes.

This also prefixes tree path with "git ".

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd3a495..92a6624 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2215,7 +2215,8 @@ M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	cpufreq at vger.kernel.org
 L:	linux-pm at vger.kernel.org
 S:	Maintained
-T:	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-MAINTAINERS-Add-git-tree-path-for-ARM-specif.patch
Type: application/octet-stream
Size: 1459 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/79deb5ba/attachment.obj>
