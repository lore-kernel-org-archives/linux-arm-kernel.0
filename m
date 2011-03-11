From: khilman@ti.com (Kevin Hilman)
Date: Fri, 11 Mar 2011 08:32:24 -0800
Subject: [GIT PULL] OMAP PM updates for 2.6.39
In-Reply-To: <AANLkTimMsYhCqqRjcBDCMDT4=iTwBG_qLHWjuxVZTmXE@mail.gmail.com>
	(Jean Pihet's message of "Fri, 11 Mar 2011 16:33:40 +0100")
References: <87k4g6eakw.fsf@ti.com>
	<AANLkTimMsYhCqqRjcBDCMDT4=iTwBG_qLHWjuxVZTmXE@mail.gmail.com>
Message-ID: <87k4g5botj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Fri, Mar 11, 2011 at 1:59 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tony,
>>
>> Please pull the following OMAP PM related changes for the upcoming
>> 2.6.39 merge window.
>>
>> Kevin
>>
>> The following changes since commit a5abba989deceb731047425812d268daf7536575:
>>
>> ?Linux 2.6.38-rc8 (2011-03-07 21:09:37 -0800)
>>
>> are available in the git repository at:
>> ?ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.39/pm-misc
>
> Waht about the following patch? IIUC it is scheduled for .39.
>
>     perf: add OMAP support for the new power events
>

I have another branch (for_2.6.39/pm-integration) that is based on
Paul's integration branch and includes your perf patch.

Once Tony pulls Paul's integration branch, I will send Tony a 2nd pull
request for this branch.

Kevin
