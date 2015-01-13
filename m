From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 13 Jan 2015 07:27:50 -0500
Subject: [PATCH 3.19-rc2 v13 4/5] ARM: Add support for on-demand
 backtrace of other CPUs
In-Reply-To: <54B4F52D.8010403@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1420469699-25350-1-git-send-email-daniel.thompson@linaro.org>
 <1420469699-25350-5-git-send-email-daniel.thompson@linaro.org>
 <20150105101925.64e8ecec@gandalf.local.home>
 <20150109164801.GW12302@n2100.arm.linux.org.uk>
 <20150111183700.55ea2434@gandalf.local.home>
 <54B4F52D.8010403@linaro.org>
Message-ID: <20150113072750.432e792e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jan 2015 10:36:29 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> > We could change that hard coded 4096 to PAGE_SIZE, for those archs with
> > bigger pages.
> 
> I've just updated the patchset with a couple of patches to common up the
> printk code between arm and x86.
> 
> Just for the record I haven't changed the hard coded 4096 as part of
> this. I'd be quite happy to but I didn't want to introduce any "secret"
> changes to the code whilst the patch header claims I am just copying stuff.

Adding a separate patch would be fine by me.

-- Steve
