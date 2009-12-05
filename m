From: dwalker@codeaurora.org (Daniel Walker)
Date: Sat, 05 Dec 2009 15:12:17 -0800
Subject: tree with htc dream support
In-Reply-To: <20091205221100.GA32522@elf.ucw.cz>
References: <20091205221100.GA32522@elf.ucw.cz>
Message-ID: <1260054737.23633.35.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-12-05 at 23:11 +0100, Pavel Machek wrote:
> Hi!
> 
> Where is the tree with HTC Dream support? I thought it was 
> 
> http://git.kernel.org/?p=linux/kernel/git/dwalker/linux-msm.git;a=summary
> 
> but it does not seem to contain basic dream support (board file and
> serial console) and I thought that was going to linus for 2.6.33...?

It's here

git://codeaurora.org/quic/kernel/dwalker/linux-msm.git

In the "testing" branch .. 

or

https://www.codeaurora.org/gitweb/quic/kernel/?p=dwalker/linux-msm.git;a=shortlog;h=refs/heads/testing

It's been in Linux-next for maybe two weeks .. I've been trying to
decide if I should submit it for 2.6.33. I'm going to be adding boat
loads of additional msm code and doing a fairly large merge for
2.6.34 .. So your code would get better testing if we wait for that.

However, If you really want it in 2.6.33 I'll try to accommodate you.

Daniel
