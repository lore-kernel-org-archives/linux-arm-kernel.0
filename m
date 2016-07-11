From: john@phrozen.org (John Crispin)
Date: Mon, 11 Jul 2016 22:31:45 +0200
Subject: [PATCH V8 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <20160711192211.GI3701@sirena.org.uk>
References: <1468240179-7558-1-git-send-email-john@phrozen.org>
 <20160711180805.GG3701@sirena.org.uk>
 <cef78bd8-9a4a-e848-d7cb-13a27127f11e@phrozen.org>
 <20160711192211.GI3701@sirena.org.uk>
Message-ID: <c1acbf13-93a0-4257-ee48-4885a87fede5@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/07/2016 21:22, Mark Brown wrote:
> On Mon, Jul 11, 2016 at 08:55:24PM +0200, John Crispin wrote:
>> On 11/07/2016 20:08, Mark Brown wrote:
>>> On Mon, Jul 11, 2016 at 02:29:38PM +0200, John Crispin wrote:
> 
>>>> This is a resend as V7 was dropped due to a merge order conflict.
> 
>>> What were the dependencies and why will simply resending this resolve
>>> them?
> 
>> the dependency was the mt6323 support inside the mt6397 MFD device [1]
>> and the headers that it included. this has been merged so the regulator
>> driver is good to go for 4.8
> 
> No, that's not resolving the dependencies - if I apply these patches
> without the dependencies in the regulator tree that will still break the
> build for my tree until after the merge window.  It'll also break Linus'
> tree if (as is normal) I send my pull requests early on.  I'd need to
> merge the MFD commits into my tree which would need coordination with
> Lee, he'd need to make a tag for me to pull in.
> 

hi,

maybe i am missing something here, but i can see the dependencies inside
the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git. is
this not the tree i should base patches on for v4.8 ?

	John
