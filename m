From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Aug 2013 17:54:53 +0100
Subject: [GIT PULL 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <CAGa+x85rvPTh3NyhY6rEtBN77gq6zVAW_TvT8k_fg9JbZGtJOw@mail.gmail.com>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-2-git-send-email-shawn.guo@linaro.org>
 <87li3tvnj8.fsf@linaro.org> <20130823101114.GM6617@n2100.arm.linux.org.uk>
 <CAGa+x85rvPTh3NyhY6rEtBN77gq6zVAW_TvT8k_fg9JbZGtJOw@mail.gmail.com>
Message-ID: <20130823165453.GP6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 09:47:44AM -0700, Kevin Hilman wrote:
> OK, good. I didn't realize you did all the conversions.  I thought you
> did a few to set the example and wanted others to finish converting.
> 
> Thanks for the cleanup,

It's the full thing - which is why I'm eager for there not to be residual
work.

Most of the debug stuff is self-contained, so there shouldn't be a problem
if people want to send me their debug additions directly rather than
feeding them to arm-soc.
