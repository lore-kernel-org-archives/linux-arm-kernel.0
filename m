From: robherring2@gmail.com (Rob Herring)
Date: Tue, 18 Oct 2011 09:50:22 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <20111018095331.GA17505@glitch>
References: <4E97A601.1020005@gmail.com> <20111018095331.GA17505@glitch>
Message-ID: <4E9D922E.5070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2011 04:53 AM, Domenico Andreoli wrote:
> On Thu, Oct 13, 2011 at 10:01:21PM -0500, Rob Herring wrote:
>>
>> The following changes since commit dd5e9eb0d051606ee3eda0c30222429c74e23f00:
>>
>>   Merge commit 'v3.1-rc9' into upstream/base (2011-10-13 20:30:42 -0500)
>>
>> are available in the git repository at:
>>
>>   http://sources.calxeda.com/git/kernel/linux.git gic-dt
> 
> I got this when I tried to pick you patch.
> 
> $ git fetch calxeda
> fatal: http://sources.calxeda.com/git/kernel/linux.git/info/refs not found: did you run git update-server-info on the server?
> $

Strange. I had tested it out and it worked at the time.

The git protocol is setup now, so use it:

git://sources.calxeda.com/kernel/linux.git

Rob
