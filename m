From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 21 Mar 2017 16:04:23 +0530
Subject: [PATCH] arm: spear6xx: add labels to various nodes in
 spear600.dtsi
In-Reply-To: <20170321111736.276ae093@free-electrons.com>
References: <1490090858-8866-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170321101009.GQ25659@vireshk-i7>
 <20170321111736.276ae093@free-electrons.com>
Message-ID: <20170321103423.GR25659@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-03-17, 11:17, Thomas Petazzoni wrote:
> On Tue, 21 Mar 2017 15:40:09 +0530, Viresh Kumar wrote:
> 
> > And who is going to use these labels? If you already have some code
> > using them, then please send that as well. This patch by itself
> > doesn't provide any benefits.
> 
> I'm using it for a custom platform that doesn't make sense to upstream
> the support for.

What about keeping this patch as well out of tree then? I don't see
any value in adding labels if we aren't going to use them in mainline.
And some newbie may try to send a patch coming forward to get rid of
them, which we wouldn't be able to oppose then :)

> However, if you would like them to be used mainline, I can send a patch
> that updates spear600-evb.dts to use those labels. Would this make
> sense?

If we can use the labels, then yes those can be added and no one will
oppose them.

-- 
viresh
