From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 May 2013 12:02:22 -0600
Subject: [GIT PULL] ARM: tegra: DT-related fixes needed by the USB tree
In-Reply-To: <20130529175508.GF21290@arwen.pp.htv.fi>
References: <1368831045-19105-1-git-send-email-swarren@wwwdotorg.org>
 <51A4E62D.7020206@wwwdotorg.org> <20130528174704.GH15794@arwen.pp.htv.fi>
 <20130529175508.GF21290@arwen.pp.htv.fi>
Message-ID: <51A642AE.1070905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2013 11:55 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, May 28, 2013 at 08:47:04PM +0300, Felipe Balbi wrote:
>> On Tue, May 28, 2013 at 11:15:25AM -0600, Stephen Warren wrote:
>>> On 05/17/2013 04:50 PM, Stephen Warren wrote:
>>>> Felipe, (and Alan, Greg),
>>>> 
>>>> These are the changes from the Tegra tree that need to be
>>>> merged before the Tegra USB driver patches 4-8 from Venu can
>>>> be applied. Recall that we had previously agreed on this
>>>> approach for v3.9, but Venu's patches didn't end up being
>>>> ready until now, unfortunately. I note that Venu's patches
>>>> affect both the Tegra USB and PHY drivers.
>>> 
>>> Felipe, do you know when you plan to pull this into the USB
>>> tree, and apply Venu's patches? Thanks.
>> 
>> got 35 commits testing right now. This pull is in my list for
>> tomorrow.
>> 
>> sorry for the delay, have been on a trip for the last 3 weeks and
>> now I'm catching up with emails during my vacations (next 2
>> weeks).
> 
> the tag is not pushed to where you pointed me to. Please make sure
> to git push it.
> 
> $ git fetch
> git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
> tag tegra-for-3.11-deps-for-usb fatal: Couldn't find remote ref
> refs/tags/tegra-for-3.11-deps-for-usb

Sorry about that. I could have sworn I checked that, but obviously not.

Anyway, I've pushed it now, and the command you quoted above works for
me, so I think it's replicated out already.
