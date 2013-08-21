From: mgreer@animalcreek.com (Mark A. Greer)
Date: Wed, 21 Aug 2013 13:31:31 -0700
Subject: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
In-Reply-To: <5214C372.3080402@baylibre.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com>
 <5214C11F.8090808@baylibre.com> <5214C372.3080402@baylibre.com>
Message-ID: <20130821203131.GA6692@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 03:41:06PM +0200, Benoit Cousson wrote:
> Hi Mark,

Hi Benoit.

> In fact I cannot even apply these patches since they are referring
> the the edma controller node that does not seem to be there in
> 3.11-rc6.

I just applied them on top of k.o fd3930f (proc: more readdir
conversion bug-fixes) without issue.  I also went through the
resulting code and it looked okay.

Which repo are you applying them to?

If I should put them on top of another repo/branch, just let
me know which one.

Mark
--
