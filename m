From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 7 Apr 2015 12:43:07 -0400
Subject: [RESEND PATCH 4.0-rc5 v19 5/6] x86/nmi: Use common printk
 functions
In-Reply-To: <20150407163746.GA14115@pd.tnic>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428421083-9137-1-git-send-email-daniel.thompson@linaro.org>
 <1428421083-9137-6-git-send-email-daniel.thompson@linaro.org>
 <20150407121942.627d2165@gandalf.local.home>
 <20150407163746.GA14115@pd.tnic>
Message-ID: <20150407124307.58c7dd20@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Apr 2015 18:37:46 +0200
Borislav Petkov <bp@alien8.de> wrote:


> I would simply say:
> 
> 	err = printk_nmi_backtrace_prepare();
> 	if (err)
> 
> like sane kernel code does.
> 

Yes, that is even the better solution.

-- Steve
