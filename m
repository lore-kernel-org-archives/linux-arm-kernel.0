From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 13 May 2012 19:46:32 +0000
Subject: [PATCH v2] mmc: dt: Consolidate DT bindings
In-Reply-To: <871umou38f.fsf_-_@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <4F75D5C0.5050307@wwwdotorg.org> <871umou38f.fsf_-_@laptop.org>
Message-ID: <201205131946.33109.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 May 2012, Chris Ball wrote:
> On Fri, Mar 30 2012, Stephen Warren wrote:
> >> No progress so far. I would suggest we apply the patch below to unify
> >> the bindings we have. I tried to minimize the impact by picking the most
> >> common version for each property, but if we know about devices that would
> >> get broken by this, we may have to be more careful.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Here's a version of your MMC DT bindings patch that responds to Stephen
> Warren's review comments, refreshed against latest linux-next -- I'd
> like to get this merged for v3.5.  Since it touches many .dts files,
> should it go via arm-soc?  Thanks.

Hi Chris,

Sorry for not getting to this sooner myself and many thanks for your
taking it on!

I've verified that there are no conflicts with anything we have in
arm-soc right now, so I think it should just go through your
tree.

	Arnd
