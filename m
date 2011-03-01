From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 20:28:43 +0000
Subject: [RFC PATCH] ARM: Use generic BUG() handler
In-Reply-To: <AANLkTinMnZAupxn7oYFhqkN1Y0OD-eyN=UeRpw96no9r@mail.gmail.com>
References: <1298939263-16421-1-git-send-email-sjg@chromium.org>
	<20110301084949.GA16733@n2100.arm.linux.org.uk>
	<20110301085911.GB16733@n2100.arm.linux.org.uk>
	<19820.47240.801312.507393@pilspetsen.it.uu.se>
	<20110301100306.GA18007@n2100.arm.linux.org.uk>
	<AANLkTinMnZAupxn7oYFhqkN1Y0OD-eyN=UeRpw96no9r@mail.gmail.com>
Message-ID: <20110301202843.GD27107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 08:34:37AM -0800, Simon Glass wrote:
> It seems I am lucky with the gcc I am using. I would have thought this
> would be a pretty fundamental feature, but yes I did notice that %c
> wasn't used anywhere.

It is, and I think it's something that I found back in 2002 or so.
I've still not had the time yet to search out the bug report, and
probably won't do for some time yet.

> Would this kernel feature be acceptable as a selectable config option
> on ARM then?

If I were to ask you if you knew which GCC version supported this,
would you know that answer?

If the answer to that is no, how would you expect people configuring
the kernel to know whether they should enable or disable this option?
