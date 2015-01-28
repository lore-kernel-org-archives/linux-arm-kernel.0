From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Jan 2015 15:01:13 -0800
Subject: [REQUEST PULL] mvebu-fixes-6
In-Reply-To: <20150128172902.GA29434@lunn.ch>
References: <20150128160231.GA28862@lunn.ch> <20150128172902.GA29434@lunn.ch>
Message-ID: <20150128230113.GB3177@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 06:29:02PM +0100, Andrew Lunn wrote:
> Hi Olof
> 
> I messed up the mvebu #5 fixes pull request. Please ignore it and use
> this #6 instead.
> 
> It contains a single patch, which we need to fix an issue introduced
> by a previous fix.
> 
> Sorry for the mess up.
> 
>       Andrew
> 
> The following changes since commit 38bdf45f4aa5cb6186d50a29e6cbbd9d486a1519:
> 
>   bus: mvebu-mbus: fix support of MBus window 13 (2015-01-19 15:40:53 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-6

Hrm, would have been nice not to have to take a regression fix for a fix.

Also, please use [GIT PULL] and a subject line, since we tend to reuse them in
the commit text. ARM: mvebu fixes for v3.20 #6 or something like that would do
just fine.


-Olof
