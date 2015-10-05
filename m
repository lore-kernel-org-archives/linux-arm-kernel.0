From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 5 Oct 2015 13:29:55 -0500
Subject: [PATCH 7/7] Document the use of the arm64 contpte/nonconpte flags.
In-Reply-To: <20151005164924.GB5557@MBP.local>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
 <1443818865-19846-8-git-send-email-jeremy.linton@arm.com>
 <20151005164924.GB5557@MBP.local>
Message-ID: <5612C1A3.3040904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2015 11:49 AM, Catalin Marinas wrote:
> I recall you asked the question but I didn't have the time to reply. I
> don't think we need a command line option for this. In the "unlikely"
> event that something is broken in hardware (or software) and we want to
> disable the contiguous bit, I would rather have a Kconfig option.

	How about both? Other users of early_param_on_off() set the default 
state using kconfig. Is that an acceptable choice, or should I remove 
the command line parameter all together? I sort of expect that in a few 
years time, the whole option goes away once it been in use for a while 
and there are a number of V8 implementations widely available.
