From: geoff@infradead.org (Geoff Levand)
Date: Tue, 02 Dec 2014 12:22:07 -0800
Subject: [PATCH 0/8] arm64 kexec kernel patches V6
In-Reply-To: <20141127061947.GB2860@darkstar.nay.redhat.com>
References: <cover.1415926876.git.geoff@infradead.org>
 <20141127061947.GB2860@darkstar.nay.redhat.com>
Message-ID: <1417551727.7724.0.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, 2014-11-27 at 14:19 +0800, Dave Young wrote:
> Is there any Linaro card for the KVM soft restart issue?

  https://cards.linaro.org/browse/KWG-611

I have a skeleton patch for the fix that needs to be filled
out in both in the Linaro card and in the commit (arm64/kvm:
Add KVM cpu shutdown) my master branch here:

 http://git.linaro.org/people/geoff.levand/linux-kexec.git

-Geoff
