From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 20 Feb 2012 21:51:32 +0800
Subject: [PATCH] ARM: perf: limit sample_period to half max_period in
 non-sampling mode
In-Reply-To: <20120220133400.GF25462@mudshark.cambridge.arm.com>
References: <1329739646-17058-1-git-send-email-will.deacon@arm.com>
 <CACVXFVPHrenJO_vKJNXVaSjnKHstQ3_3NRJFqhp0dTiDAAm8tw@mail.gmail.com>
 <20120220133400.GF25462@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNW6V8J1MugwTcxDzH+qrbbtBpkiJtvWWopDHKuyMOb4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 20, 2012 at 9:34 PM, Will Deacon <will.deacon@arm.com> wrote:

> Sure, didn't want to add anything more than a CC until I was sure you were
> happy with it.

Sure, I am happy with it.

> On the plus side, the warnings from Stephane's IRQ throttling code have been
> fixed in -rc4 by f39d47ff ("perf: Fix double start/stop in
> x86_pmu_start()").

Good news.

> So the ball should be back in the OMAP court now as far as enabling perf on
> Panda.

Yes, several patches are still pending for omap4 perf support.

Also I have one patch for fixing possible oops on arm pmu, but it is a
bit late today and
I will send out it tomorrow,

thanks
--
Ming Lei
