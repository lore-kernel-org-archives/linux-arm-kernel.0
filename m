From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 18 Feb 2015 11:30:59 +0000
Subject: [PATCH 0/2] arm/arm64: Detect Xen support earlier
In-Reply-To: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
References: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
Message-ID: <1424259059.27775.17.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-02-12 at 06:34 +0000, Julien Grall wrote:
> Hello,
> 
> This small patch series move the detection of running on Xen earlier. This is
> required in order to support earlyprintk via Xen and selecting the preferred
> console.

Thanks for doing this, having all of the init done in an initcall (even
a relatively early one) has been a niggle I've wanted address for ages,
for exactly earlyprintk and preferred console reasons.

I had a very minor comment on #1 but nonetheless both patches:
Acked-by: Ian Campbell <ian.campbell@citrix.com>

Ian.
